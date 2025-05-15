import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/reels/controllers/reels_controller.dart';

class ReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReelsController>(
      () => ReelsController(),
    );
  }
}
