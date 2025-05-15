import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petspeak_ai/app/data/models/pet_model.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';

class PetProfileController extends GetxController {
  final RxList<PetModel> pets = <PetModel>[].obs;
  final RxInt selectedPetIndex = 0.obs;
  final ImagePicker _imagePicker = ImagePicker();

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  // Form values
  final RxString petType = 'dog'.obs;
  final Rx<DateTime?> birthDate = Rx<DateTime?>(null);
  final RxString gender = 'male'.obs;
  final RxString? profileImageUrl = RxString('');

  @override
  void onInit() {
    super.onInit();
    _loadPets();
  }

  @override
  void onClose() {
    nameController.dispose();
    breedController.dispose();
    weightController.dispose();
    super.onClose();
  }

  void _loadPets() {
    // Mock data - replace with actual API call
    pets.value = [
      PetModel(
        id: '1',
        name: 'Buddy',
        type: 'dog',
        breed: 'Golden Retriever',
        birthDate: DateTime(2020, 4, 15),
        gender: 'male',
        weight: 28.5,
        profileImageUrl:
            'https://images.pexels.com/photos/2253275/pexels-photo-2253275.jpeg',
      ),
      PetModel(
        id: '2',
        name: 'Luna',
        type: 'cat',
        breed: 'Siamese',
        birthDate: DateTime(2021, 1, 10),
        gender: 'female',
        weight: 4.2,
        profileImageUrl:
            'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg',
      ),
    ];
  }

  void selectPet(int index) {
    selectedPetIndex.value = index;
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null) {
        // In a real app, upload image to storage and get URL
        // For now, just show success message
        Get.snackbar(
          'Success',
          'Profile picture updated!',
          snackPosition: SnackPosition.BOTTOM,
          mainButton: TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile picture',
        snackPosition: SnackPosition.BOTTOM,
        mainButton: TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      );
    }
  }

  void updatePetType(String type) {
    petType.value = type;
  }

  void updateGender(String value) {
    gender.value = value;
  }

  Future<void> selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: birthDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      birthDate.value = picked;
    }
  }

  void savePet() {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your pet\'s name',
        snackPosition: SnackPosition.BOTTOM,
        mainButton: TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      );
      return;
    }

    // In a real app, save to backend
    Get.snackbar(
      'Success',
      'Pet profile saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK'),
      ),
    );

    Get.back();
  }

  void deletePet() {
    Get.defaultDialog(
      title: 'Delete Pet',
      middleText:
          'Are you sure you want to delete this pet profile? This action cannot be undone.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        // In a real app, delete from backend
        Get.back();
        Get.snackbar(
          'Success',
          'Pet profile deleted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          mainButton: TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        );
      },
    );
  }

  void navigateToSubscription() {
    Get.toNamed(Routes.SUBSCRIPTION);
  }
}
