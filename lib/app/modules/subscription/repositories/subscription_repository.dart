import '../../../data/models/subscription_plan_model.dart';

class SubscriptionRepository {
  // Singleton pattern
  static final SubscriptionRepository _instance =
      SubscriptionRepository._internal();

  factory SubscriptionRepository() => _instance;

  SubscriptionRepository._internal();

  // Get all subscription plans
  List<SubscriptionPlan> getAll() {
    return [
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
  }

  SubscriptionPlan getPopularPlan() {
    return getAll()
        .firstWhere((plan) => plan.isPopular, orElse: () => getAll().first);
  }
}
