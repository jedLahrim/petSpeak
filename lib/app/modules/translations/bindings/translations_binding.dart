import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/translations/controllers/translations_controller.dart';

class TranslationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranslationsController>(
      () => TranslationsController(),
    );
  }
}
