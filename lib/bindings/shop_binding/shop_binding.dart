import 'package:get/get.dart';
import '../../controllers/shop_controller/shop_controller.dart';


class ShopBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(ShopController());
  }
}