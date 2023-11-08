import 'package:get/get.dart';
import '../../models/address_model/address_model.dart';
import '../../services/address/get_address/get_address.dart';

class AddressController extends GetxController {
  var isLoading = true.obs;
  final RxList<Address> addressList = <Address>[].obs;
  final RxList<String> addressError = <String>[].obs;
  String? popMenuValue;

  @override
  void onInit() {
    fetchAddress();
    super.onInit();
  }

  void fetchAddress() async {
    try {
      var address = await RemoteServicesAddress.fetchAddress();
      addressList.value = address;
      addressError.clear();
    } catch (error) {
      addressError.add(error.toString());
    } finally {
      update();
      isLoading(false);
    }
  }

  void changePopMenuValueWhenPutAddress(data) async {
    var addressData = data['data']['Address'];
    addressData['type'] == 1
        ? popMenuValue = "Home (${addressData["street"].toString()})"
        : addressData['type'] == 2
            ? popMenuValue = "Work (${addressData["street"].toString()})"
            : popMenuValue = "Other (${addressData["street"].toString()})";
    update();
  }
}
