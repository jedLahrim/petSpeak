import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';

class OnboardingPage {
  final String title;
  final String description;
  final String animationPath;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.animationPath,
  });
}

class OnboardingController extends GetxController {
  late PageController pageController;
  final RxInt currentPage = 0.obs;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'Understand Your Pet',
      description:
          'Translate your pet\'s sounds into human language and discover what they are trying to tell you.',
      animationPath: 'assets/animations/pet_translation.json',
    ),
    OnboardingPage(
      title: 'Expert Vet Advice',
      description:
          'Get personalized veterinary advice and answers to your pet health questions instantly.',
      animationPath: 'assets/animations/pet_health.json',
    ),
    OnboardingPage(
      title: 'Connect with Other Pets',
      description:
          'Share your pet\'s translations and explore a community of pet owners and their furry friends.',
      animationPath: 'assets/animations/pet_social.json',
    ),
    OnboardingPage(
      title: 'Premium Features',
      description:
          'Unlock advanced translation features, unlimited vet consultations, and exclusive content.',
      animationPath: 'assets/animations/pet_premium.json',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void next() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skip() {
    pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void start() {
    // Navigate to authentication or home screen
    Get.offAllNamed(Routes.LOGIN);
  }
}
