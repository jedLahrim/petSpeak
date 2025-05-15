import 'package:get/get.dart';
import 'package:petspeak_ai/app/data/services/storage_service.dart';

class SplashController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  void _initialize() async {
    // Simulate loading process
    // await Future.delayed(const Duration(seconds: 2));

    // Check if this is the first launch
    // if (_storageService.isFirstLaunch) {
    //   _storageService.isFirstLaunch = false;
    // Get.offAllNamed(Routes.ONBOARDING);
    // } else {
    // TODO: Check if user is logged in, then navigate to HOME or authentication
    // Get.offAllNamed(Routes.HOME);
    // }
  }
}
