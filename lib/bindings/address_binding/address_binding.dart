import 'package:get/get.dart';
import '../../controllers/addresses_controller/addresses_controller.dart';

class AddressesBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(AddressesController(),permanent: true);
  }

}