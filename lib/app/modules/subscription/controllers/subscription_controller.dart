import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPlan {
  final String id;
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool isPopular;

  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    this.isPopular = false,
  });
}

class SubscriptionController extends GetxController {
  final RxString selectedPlanId = ''.obs;
  final RxBool isLoading = false.obs;
  final ScrollController scrollController = ScrollController();
  final ScrollController pageScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // Select the most popular plan by default
    final popularPlan = plans.firstWhere((plan) => plan.isPopular);
    selectedPlanId.value = popularPlan.id;
  }

  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      id: 'basic',
      title: 'Basic',
      price: '\$4.99',
      period: 'month',
      features: [
        'Unlimited pet translations',
        'Basic health tips',
        'Community access',
        'Ad-free experience',
      ],
    ),
    SubscriptionPlan(
      id: 'premium',
      title: 'Premium',
      price: '\$9.99',
      period: 'month',
      features: [
        'All Basic features',
        'Advanced health tracking',
        'Priority vet consultations',
        'Exclusive content access',
        'Multiple pet profiles',
      ],
      isPopular: true,
    ),
    SubscriptionPlan(
      id: 'family',
      title: 'Family',
      price: '\$14.99',
      period: 'month',
      features: [
        'All Premium features',
        'Up to 5 family members',
        'Shared pet profiles',
        'Family event planning',
        'Premium support',
      ],
    ),
  ];

  void startAutoScrollAnimation() {
    // First scroll to the end after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }

      // Then scroll back to the most popular plan after 1.5 seconds
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (scrollController.hasClients) {
          final popularPlanIndex = plans.indexWhere((plan) => plan.isPopular);
          if (popularPlanIndex != -1) {
            scrollController.animateTo(
              (280.0 + 16) * popularPlanIndex, // card width + margin
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void selectPlan(String planId) {
    // Set the selected plan
    selectedPlanId.value = planId;

    // Scroll to the subscribe button after selecting a plan
    Future.delayed(const Duration(milliseconds: 300), () {
      if (pageScrollController.hasClients) {
        pageScrollController.animateTo(
          pageScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> subscribe() async {
    if (selectedPlanId.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a subscription plan',
        snackPosition: SnackPosition.BOTTOM,
        mainButton: TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Subscription activated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        mainButton: TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process subscription',
        snackPosition: SnackPosition.BOTTOM,
        mainButton: TextButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void restorePurchases() {
    Get.snackbar(
      'Restore Purchases',
      'Checking for previous purchases...',
      snackPosition: SnackPosition.BOTTOM,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('OK'),
      ),
    );
  }
}
