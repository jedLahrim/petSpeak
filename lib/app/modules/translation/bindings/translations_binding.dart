import 'package:get/get.dart';

import '../controllers/translations_controller.dart';

class TranslationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranslationsController>(
      () => TranslationsController(),
    );
  }
}
