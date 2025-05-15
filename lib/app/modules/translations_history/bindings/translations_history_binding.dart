import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/translations_history/controllers/translations_history_controller.dart';

class TranslationsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranslationsHistoryController>(
      () => TranslationsHistoryController(),
    );
  }
}
