import 'package:get/get.dart';
import '../../controllers/item_shop_controller/item_shop_controller.dart';



class ItemShopBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(ItemShopController());
  }
}