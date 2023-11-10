import 'package:get/get.dart';
import '../../controllers/checkout_controller/checkout_controller.dart';


class CheckOutBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(CheckOutController(),permanent: true);
  }
}