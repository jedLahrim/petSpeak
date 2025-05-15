import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/ask_vet/controllers/ask_vet_controller.dart';

class AskVetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AskVetController>(
      () => AskVetController(),
    );
  }
}
