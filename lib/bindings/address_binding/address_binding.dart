import 'package:get/get.dart';
import '../../controllers/address_controller/address_controller.dart';

class AddressBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(AddressController(),permanent: true);
  }

}