import 'package:get/get.dart';
import '../../models/address_model/address_model.dart';
import '../../services/address/get_address/get_address.dart';

class AddressController extends GetxController{
  var isLoading=true.obs;
  final RxList<Address> addressList = <Address>[].obs;
  final RxList<String> addressError = <String>[].obs;
  @override
  void onInit() {
    fetchAddress();
    super.onInit();
  }
  void fetchAddress() async{
    try {
      var address = await RemoteServicesAddress.fetchAddress();
      addressList.assignAll(address);
      addressList.refresh();
      addressError.clear();
    } catch (error) {
      addressError.add(error.toString());
    } finally {
      update();
      isLoading(false);
    }

  }
}