import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';
import 'package:petspeak_ai/global_widgets/subscription_card.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Features'),
      ),
      body: SingleChildScrollView(
        controller: controller.verticalScrollController,
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Subscription plans
            _buildSubscriptionPlans(context),

            // Features list
            _buildFeaturesList(context),

            // Subscribe button
            _buildSubscribeButton(context),

            // Restore purchases
            _buildRestorePurchases(context),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Unlock Premium Features',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Get unlimited access to all features and enhance your pet communication experience',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPlans(BuildContext context) {
    // After the widget builds, animate the scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startAutoScrollAnimation();
    });

    return SizedBox(
      height: 500,
      child: ListView.builder(
        controller: controller.horizontalScrollController,
        // Assign the controller
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.plans.length,
        itemBuilder: (context, index) {
          final plan = controller.plans[index];
          return Obx(() => SubscriptionCard(
                title: plan.title,
                price: plan.price,
                period: plan.period,
                features: plan.features,
                isPopular: plan.isPopular,
                isCurrentPlan: false,
                isSelected: controller.selectedPlanId.value == plan.id,
                onSubscribe: () => controller.selectPlan(plan.id),
              ));
        },
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final features = [
      {
        'icon': Icons.translate,
        'title': 'Advanced Translation',
        'description': 'Get more accurate translations with context awareness',
      },
      {
        'icon': Icons.medical_services,
        'title': 'Priority Vet Access',
        'description': 'Connect with veterinarians instantly',
      },
      {
        'icon': Icons.analytics,
        'title': 'Health Analytics',
        'description': 'Track your pet\'s health metrics over time',
      },
      {
        'icon': Icons.video_library,
        'title': 'Exclusive Content',
        'description': 'Access premium training videos and guides',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Premium Features',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        feature['icon'] as IconData,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feature['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            feature['description'] as String,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(() {
        final isLoading = controller.isLoading.value;
        final selectedPlanId = controller.selectedPlanId.value;

        return ElevatedButton(
          onPressed:
              isLoading || selectedPlanId.isEmpty ? null : controller.subscribe,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text('Subscribe Now'),
        );
      }),
    );
  }

  Widget _buildRestorePurchases(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already purchased? ',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          GestureDetector(
            onTap: controller.restorePurchases,
            child: const Text(
              'Restore Purchases',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
