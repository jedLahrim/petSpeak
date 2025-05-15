import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/data/models/translation_model.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';

class TranslationFilter {
  String petType;
  String mode;
  bool favoritesOnly;

  TranslationFilter({
    this.petType = 'all',
    this.mode = 'all',
    this.favoritesOnly = false,
  });
}

class TranslationsHistoryController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<TranslationModel> translations = <TranslationModel>[].obs;
  final RxList<TranslationModel> filteredTranslations =
      <TranslationModel>[].obs;
  final TranslationFilter filter = TranslationFilter();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTranslations();
  }

  void _loadTranslations() {
    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      translations.value = [
        TranslationModel(
          id: '1',
          petId: '1',
          mode: 'pet-to-human',
          petType: 'dog',
          audioPath: 'path/to/audio1.mp3',
          originalText: 'Woof woof!',
          translatedText: 'I\'m really excited to go for a walk!',
          createdAt: DateTime.now(),
          language: 'English',
          isFavorite: true,
        ),
        TranslationModel(
          id: '2',
          petId: '1',
          mode: 'human-to-pet',
          petType: 'dog',
          audioPath: 'path/to/audio2.mp3',
          originalText: 'Do you want a treat?',
          translatedText: 'Bark bark! (Yes, I would love one!)',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          language: 'English',
          isFavorite: false,
        ),
        TranslationModel(
          id: '3',
          petId: '2',
          mode: 'pet-to-human',
          petType: 'cat',
          audioPath: 'path/to/audio3.mp3',
          originalText: 'Meow meow',
          translatedText: 'My food bowl is empty, please fill it now!',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          language: 'English',
          isFavorite: false,
        ),
        TranslationModel(
          id: '4',
          petId: '2',
          mode: 'human-to-pet',
          petType: 'cat',
          audioPath: 'path/to/audio4.mp3',
          originalText: 'I love you so much',
          translatedText: '*gentle purring* Meow... *slow blink*',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          language: 'English',
          isFavorite: true,
        ),
      ];

      _applyFiltersAndSearch();
      isLoading.value = false;
    });
  }

  void _applyFiltersAndSearch() {
    List<TranslationModel> result = translations;

    // Apply pet type filter
    if (filter.petType != 'all') {
      result = result.where((t) => t.petType == filter.petType).toList();
    }

    // Apply mode filter
    if (filter.mode != 'all') {
      result = result.where((t) => t.mode == filter.mode).toList();
    }

    // Apply favorites filter
    if (filter.favoritesOnly) {
      result = result.where((t) => t.isFavorite).toList();
    }

    // Apply search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      result = result
          .where((t) =>
              t.originalText.toLowerCase().contains(query) ||
              t.translatedText.toLowerCase().contains(query))
          .toList();
    }

    filteredTranslations.value = result;
  }

  void searchTranslations(String query) {
    searchQuery.value = query;
    _applyFiltersAndSearch();
  }

  void clearSearch() {
    searchQuery.value = '';
    _applyFiltersAndSearch();
  }

  void applyFilters({
    required String petType,
    required String mode,
    required bool favoritesOnly,
  }) {
    filter.petType = petType;
    filter.mode = mode;
    filter.favoritesOnly = favoritesOnly;

    _applyFiltersAndSearch();
  }

  void clearFilters() {
    filter.petType = 'all';
    filter.mode = 'all';
    filter.favoritesOnly = false;

    _applyFiltersAndSearch();
  }

  void playAudio(TranslationModel translation) {
    Get.snackbar(
      'Playing Audio',
      'Now playing audio recording...',
      snackPosition: SnackPosition.BOTTOM,
    );

    // In a real app, this would play the audio recording
  }

  void shareTranslation(TranslationModel translation) {
    Get.snackbar(
      'Share',
      'Sharing options opened!',
      snackPosition: SnackPosition.BOTTOM,
    );

    // In a real app, this would open share options
  }

  void toggleFavorite(TranslationModel translation) {
    // Find and update the translation in both lists
    final index = translations.indexWhere((t) => t.id == translation.id);
    if (index != -1) {
      final updatedTranslation = translation.copyWith(
        isFavorite: !translation.isFavorite,
      );

      translations[index] = updatedTranslation;

      // Update filtered list if it contains this translation
      final filteredIndex =
          filteredTranslations.indexWhere((t) => t.id == translation.id);
      if (filteredIndex != -1) {
        filteredTranslations[filteredIndex] = updatedTranslation;
      }

      Get.snackbar(
        updatedTranslation.isFavorite
            ? 'Added to Favorites'
            : 'Removed from Favorites',
        updatedTranslation.isFavorite
            ? 'Translation added to your favorites!'
            : 'Translation removed from your favorites!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void deleteTranslation(TranslationModel translation) {
    Get.defaultDialog(
      title: 'Delete Translation',
      middleText:
          'Are you sure you want to delete this translation? This action cannot be undone.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        // Remove the translation from both lists
        translations.removeWhere((t) => t.id == translation.id);
        filteredTranslations.removeWhere((t) => t.id == translation.id);

        Get.back();
        Get.snackbar(
          'Deleted',
          'Translation has been deleted!',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void navigateToTranslations() {
    Get.toNamed(Routes.TRANSLATIONS);
  }
}
