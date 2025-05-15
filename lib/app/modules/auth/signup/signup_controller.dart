import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SignupController extends GetxController {
  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final scrollController = ScrollController();

  // State variables
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final acceptTerms = false.obs;
  final isLoading = false.obs;
  final errorMessage = RxString('');
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Scroll to the bottom after 800ms
    Future.delayed(const Duration(milliseconds: 800), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();

  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  void toggleAcceptTerms() => acceptTerms.toggle();

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      if (!acceptTerms.value) {
        errorMessage.value = 'Please accept the terms and conditions';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        );
        return;
      }

      isLoading.value = true;
      errorMessage.value = '';

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock registration logic
      final success = await mockRegister(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      isLoading.value = false;

      if (success) {
        Get.offNamed(Routes.TRANSLATIONS);
      } else {
        errorMessage.value = 'Registration failed. Please try again.';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        );
      }
    }
  }

  Future<bool> mockRegister(String name, String email, String password) async {
    // In a real app, this would call your authentication service
    return true; // Mock success
  }

  void loginWithGoogle() {
    Get.snackbar(
      'Notice',
      'Google login not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK'),
      ),
    );
  }

  void continueAsGuest() {
    Get.offNamed(Routes.TRANSLATIONS);
  }

  void navigateToLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  // Validators
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
