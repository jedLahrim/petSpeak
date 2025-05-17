import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/subscription_plan_model.dart';
import '../../../data/services/scroll_service.dart';
import '../repositories/subscription_repository.dart';

class SubscriptionController extends GetxController {
  final ScrollService scrollService = Get.put<ScrollService>(ScrollService());
  final SubscriptionRepository subscriptionRepo = SubscriptionRepository();
  final RxString selectedPlanId = ''.obs;
  final RxBool isLoading = false.obs;

  // Constants for subscription UI elements
  static const double planCardWidth = 280.0;
  static const double planCardSpacing = 16.0;

  // Model for subscription plans
  List<SubscriptionPlan> get plans => subscriptionRepo.getAll();

  @override
  void onInit() {
    super.onInit();

    // Select the most popular plan by default
    final popularPlan =
        plans.firstWhere((plan) => plan.isPopular, orElse: () => plans.first);
    selectedPlanId.value = popularPlan.id;
  }

  // Easy access to controllers for the subscription screen
  ScrollController get horizontalScrollController =>
      scrollService.getHorizontalController('subscription');

  ScrollController get verticalScrollController =>
      scrollService.getVerticalController('subscription');

  // Public methods for UI interactions
  void swipeToPlan(String planId) {
    final planIndex = plans.indexWhere((plan) => plan.id == planId);
    if (planIndex == -1) return;

    scrollService.scrollHorizontalToItem(
      screenName: 'subscription',
      itemIndex: planIndex,
      itemWidth: planCardWidth,
      itemSpacing: planCardSpacing,
    );
  }

  void startAutoScrollAnimation() {
    scrollService.chainScrollActions(
      actions: [
        // First scroll to the end
        () => scrollService.scrollHorizontalToEnd(screenName: 'subscription'),
        // Then scroll back to the most popular plan
        () {
          final popularPlan = plans.firstWhere((plan) => plan.isPopular,
              orElse: () => plans.first);
          swipeToPlan(popularPlan.id);
        },
      ],
      delays: [
        1000,
        1500
      ], // Delay 1s before first action, then 1.5s before second action
    );
  }

  void selectPlan(String planId) {
    // Set the selected plan
    selectedPlanId.value = planId;

    // Chain scroll actions: first to the selected plan, then to the subscribe button
    scrollService.chainScrollActions(
      actions: [
        () => swipeToPlan(planId),
        () => scrollService.scrollVerticalToBottom(screenName: 'subscription'),
      ],
      delays: [200, 500],
    );
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
