import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/ask_vet/bindings/ask_vet_binding.dart';
import 'package:petspeak_ai/app/modules/ask_vet/views/ask_vet_view.dart';
import 'package:petspeak_ai/app/modules/home/bindings/home_binding.dart';
import 'package:petspeak_ai/app/modules/home/views/home_view.dart';
import 'package:petspeak_ai/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:petspeak_ai/app/modules/onboarding/views/onboarding_view.dart';
import 'package:petspeak_ai/app/modules/pet_profile/bindings/pet_profile_binding.dart';
import 'package:petspeak_ai/app/modules/pet_profile/views/pet_profile_view.dart';
import 'package:petspeak_ai/app/modules/reels/bindings/reels_binding.dart';
import 'package:petspeak_ai/app/modules/reels/views/reels_view.dart';
import 'package:petspeak_ai/app/modules/splash/bindings/splash_binding.dart';
import 'package:petspeak_ai/app/modules/splash/views/splash_view.dart';
import 'package:petspeak_ai/app/modules/subscription/bindings/subscription_binding.dart';
import 'package:petspeak_ai/app/modules/subscription/views/subscription_view.dart';
import 'package:petspeak_ai/app/modules/translations/bindings/translations_binding.dart';
import 'package:petspeak_ai/app/modules/translations/views/translations_view.dart';
import 'package:petspeak_ai/app/modules/translations_history/bindings/translations_history_binding.dart';
import 'package:petspeak_ai/app/modules/translations_history/views/translations_history_view.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';

import '../modules/auth/login/login_binding.dart';
import '../modules/auth/login/login_view.dart';
import '../modules/auth/signup/signup_binding.dart';
import '../modules/auth/signup/signup_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.TRANSLATIONS,
      page: () => const TranslationsView(),
      binding: TranslationsBinding(),
    ),
    GetPage(
      name: Routes.TRANSLATIONS_HISTORY,
      page: () => const TranslationsHistoryView(),
      binding: TranslationsHistoryBinding(),
    ),
    GetPage(
      name: Routes.ASK_VET,
      page: () => const AskVetView(),
      binding: AskVetBinding(),
    ),
    GetPage(
      name: Routes.PET_PROFILE,
      page: () => const PetProfileView(),
      binding: PetProfileBinding(),
    ),
    GetPage(
      name: Routes.REELS,
      page: () => const ReelsView(),
      binding: ReelsBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
  ];
}
