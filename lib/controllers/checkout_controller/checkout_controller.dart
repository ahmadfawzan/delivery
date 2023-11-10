import 'package:get/get.dart';
import '../../models/address_model/address_model.dart';
import '../address_controller/address_controller.dart';

class CheckOutController extends GetxController {
  final AddressController addressController = Get.find();
  final RxList<Address> changeAddressList = <Address>[].obs;
  List popMenuValueCheckOut = [];
  String phoneNumber='';

  void PopMenuValueCheckOut() {
    popMenuValueCheckOut = addressController.addressList
        .where((item) =>
            (item.type == 1
                ? "Home (${item.street.toString()})"
                : item.type == 2
                    ? "Work (${item.street.toString()})"
                    : "Other (${item.street.toString()})") ==
            (addressController.popMenuValue?.isNotEmpty ?? false
                ? addressController.popMenuValue
                : addressController.addressList[0].type == 1
                    ? "Home (${addressController.addressList[0].street})"
                    : addressController.addressList[0].type == 2
                        ? "Work (${addressController.addressList[0].street})"
                        : "Other (${addressController.addressList[0].street})"))
        .toList();
    update();
  }
}
