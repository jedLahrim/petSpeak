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

  void selectPlan(String planId) {
    selectedPlanId.value = planId;
  }

  Future<void> subscribe() async {
    if (selectedPlanId.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a subscription plan',
        snackPosition: SnackPosition.BOTTOM,
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
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process subscription',
        snackPosition: SnackPosition.BOTTOM,
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
    );
  }
}
