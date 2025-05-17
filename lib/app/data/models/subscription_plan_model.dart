// lib/data/models/subscription_plan_model.dart
class SubscriptionPlan {
  final String id;
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool isPopular;

  const SubscriptionPlan({
    required this.id,
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    this.isPopular = false,
  });
}
