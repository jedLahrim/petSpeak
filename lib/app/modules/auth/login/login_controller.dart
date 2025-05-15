import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // State variables
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final RxString? error = ''.obs;
  final rememberMe = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();

  void toggleRememberMe() => rememberMe.toggle();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      final success = 'login here';

      if (success.isNotEmpty) {
        Get.offNamed(Routes.TRANSLATIONS);
      }
    }
  }

  Future<void> loginWithGoogle() async {
    // Implement Google login logic
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
    Get.offNamed(Routes.REELS);
  }

  void navigateToSignUp() {
    Get.toNamed(Routes.SIGNUP);
  }

  void navigateToForgotPassword() {
    // Implement forgot password navigation
    Get.snackbar(
      'Notice',
      'Forgot password not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK'),
      ),
    );
  }

  // Validators
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
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
