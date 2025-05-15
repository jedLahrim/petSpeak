import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/pet_profile/controllers/pet_profile_controller.dart';

import '../controllers/theme_controller.dart';

class PetProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetProfileController>(
      () => PetProfileController(),
    );
    Get.put<ThemeController>(
      ThemeController(),
      permanent: true,
    );
  }
}
