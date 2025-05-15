import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/splash/controllers/splash_controller.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Paw Logo
              Animate(
                effects: [
                  ScaleEffect(
                    begin: const Offset(0, 0),
                    end: const Offset(1.2, 1.2),
                    curve: Curves.easeOutBack,
                    duration: 600.ms,
                  ),
                  ScaleEffect(
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(1, 1),
                    curve: Curves.easeOut,
                    duration: 300.ms,
                    delay: 600.ms,
                  ),
                  FadeEffect(duration: 600.ms)
                ],
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.solid,
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.pets_sharp,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // App name
              Animate(
                effects: [
                  FadeEffect(duration: 600.ms, delay: 800.ms),
                  SlideEffect(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                    duration: 600.ms,
                    delay: 800.ms,
                    curve: Curves.easeOut,
                  )
                ],
                child: const Text(
                  'PetSpeak AI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Tagline
              Animate(
                effects: [
                  FadeEffect(duration: 600.ms, delay: 1200.ms),
                  SlideEffect(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                    duration: 600.ms,
                    delay: 1200.ms,
                    curve: Curves.easeOut,
                  )
                ],
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Understanding your pets has never been easier',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Get Started Button
              Animate(
                effects: [
                  FadeEffect(duration: 600.ms, delay: 1600.ms),
                  SlideEffect(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                    duration: 600.ms,
                    delay: 1600.ms,
                    curve: Curves.easeOut,
                  )
                ],
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.ONBOARDING);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Login link
              Animate(
                effects: [
                  FadeEffect(duration: 600.ms, delay: 1800.ms),
                ],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
