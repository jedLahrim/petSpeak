import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';

class TranslationsController extends GetxController {
  final ScrollController scrollController = ScrollController();
  bool _shouldScroll = true;

  bool get shouldScroll => _shouldScroll;

  // Translation mode
  final RxString mode = 'pet-to-human'.obs;

  // Pet type
  final RxString petType = 'dog'.obs;

  // Language
  final RxString language = 'en'.obs;

  // Recording state
  final RxBool isRecording = false.obs;

  // Translation results
  final RxString originalText = ''.obs;
  final RxString translationResult = ''.obs;

  // Mock languages
  final List<Map<String, dynamic>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'es', 'name': 'Spanish', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'French', 'flag': '🇫🇷'},
    {'code': 'de', 'name': 'German', 'flag': '🇩🇪'},
    {'code': 'it', 'name': 'Italian', 'flag': '🇮🇹'},
    {'code': 'pt', 'name': 'Portuguese', 'flag': '🇵🇹'},
    {'code': 'ru', 'name': 'Russian', 'flag': '🇷🇺'},
    {'code': 'ja', 'name': 'Japanese', 'flag': '🇯🇵'},
    {'code': 'zh', 'name': 'Chinese', 'flag': '🇨🇳'},
    {'code': 'ko', 'name': 'Korean', 'flag': '🇰🇷'},
  ];

  // Navigation
  void onNavItemTapped(int index) {
    switch (index) {
      case 0: // Home
        Get.offAllNamed(Routes.HOME);
        break;
      case 1: // Translate - already here
        break;
      case 2: // Reels
        Get.offAllNamed(Routes.REELS);
        break;
      case 3: // Ask Vet
        Get.offAllNamed(Routes.ASK_VET);
        break;
      case 4: // Profile
        Get.offAllNamed(Routes.PET_PROFILE);
        break;
    }
  }

  // Set translation mode
  void setMode(String newMode) {
    mode.value = newMode;
    // Clear any previous translation
    _clearTranslation();
  }

  // Set pet type
  void setPetType(String newPetType) {
    petType.value = newPetType;
    // Clear any previous translation
    _clearTranslation();
  }

  // Set language
  void setLanguage(String newLanguage) {
    language.value = newLanguage;
    // If there's an existing translation, retranslate
    if (translationResult.value.isNotEmpty) {
      _translateText();
    }
  }

  // Method to trigger scroll
  void triggerScroll() {
    _shouldScroll = true;
    update(); // Notify GetBuilder to rebuild
  }

  // Method to reset scroll (called after scrolling)
  void resetScroll() {
    _shouldScroll = false;
  }

  // Toggle recording
  void toggleRecording() {
    if (isRecording.value) {
      // Stop recording
      isRecording.value = false;

      // In a real app, this would process the recording
      // For this demo, we'll use mock data
      _processRecording();
    } else {
      // Start recording
      _clearTranslation();
      isRecording.value = true;
    }
  }

  // Clear translation
  void _clearTranslation() {
    originalText.value = '';
    translationResult.value = '';
  }

  // Process recording (mock)
  void _processRecording() {
    // Simulate processing delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mode.value == 'pet-to-human') {
        _processPetToHuman();
      } else {
        _processHumanToPet();
      }
    });
  }

  void scrollToBottom(ScrollController scrollController) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  // Process pet to human translation (mock)
  void _processPetToHuman() {
    if (petType.value == 'dog') {
      originalText.value = 'Woof! Woof woof!';
    } else {
      originalText.value = 'Meow meow!';
    }

    _translateText();
  }

  // Process human to pet translation (mock)
  void _processHumanToPet() {
    originalText.value = 'I love you so much!';
    _translateText();
  }

  // Translate text (mock)
  void _translateText() {
    try {
      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mode.value == 'pet-to-human') {
          if (petType.value == 'dog') {
            if (language.value == 'en') {
              translationResult.value =
                  'I\'m so excited to see you! Can we go for a walk?';
            } else if (language.value == 'es') {
              translationResult.value =
                  '¡Estoy muy emocionado de verte! ¿Podemos ir a caminar?';
            } else {
              translationResult.value =
                  'I\'m so excited to see you! Can we go for a walk?';
            }
          } else {
            if (language.value == 'en') {
              translationResult.value =
                  'Excuse me, but my food bowl is empty. Please attend to it immediately.';
            } else if (language.value == 'es') {
              translationResult.value =
                  'Disculpa, pero mi plato de comida está vacío. Por favor atiéndelo inmediatamente.';
            } else {
              translationResult.value =
                  'Excuse me, but my food bowl is empty. Please attend to it immediately.';
            }
          }
        } else {
          if (petType.value == 'dog') {
            translationResult.value =
                'Woof woof! *tail wagging excitedly* Woof!';
          } else {
            translationResult.value = '*gentle purring* Meow... *slow blink*';
          }
        }

        // Use addPostFrameCallback to scroll after the UI has updated
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   scrollToBottom(scrollController);
        // });
        triggerScroll();
      });
    } catch (e) {
      rethrow;
    }
  }

  // Replay audio
  void replayAudio() {
    Get.snackbar(
      'Replay',
      'Playing audio recording...',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK'),
      ),
    );

    // In a real app, this would play the audio recording
  }

  // Save translation
  void saveTranslation() {
    Get.snackbar(
      'Saved',
      'Translation saved to your history!',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK'),
      ),
    );

    // In a real app, this would save the translation to history
  }

  // Share translation
  void shareTranslation() {
    Get.snackbar(
      'Share',
      'Sharing options opened!',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK'),
      ),
    );

    // In a real app, this would open share options
  }

  // Navigate to history
  void navigateToHistory() {
    Get.toNamed(Routes.TRANSLATIONS_HISTORY);
  }
}
