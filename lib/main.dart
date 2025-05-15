import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petspeak_ai/app/data/services/storage_service.dart';
import 'package:petspeak_ai/app/routes/app_pages.dart';
import 'package:petspeak_ai/app/utils/theme/app_theme.dart';

import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    if (kDebugMode) {
      print('Firebase initialization failed: $e');
    }
  }

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const PetSpeakApp());
}

class PetSpeakApp extends StatelessWidget {
  const PetSpeakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PetSpeak AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.SPLASH,
      initialBinding: SplashBinding(),
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
      // transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
