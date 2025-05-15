import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/subscription/controllers/subscription_controller.dart';

class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
    );
  }
}
