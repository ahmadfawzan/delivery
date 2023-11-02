import 'package:delivery/services/addresses/get_addresses/get_addresses.dart';
import 'package:get/get.dart';
import '../../model/address_model/address_model.dart';

class AddressesController extends GetxController{
  final RxList<Addresses> addressesList = <Addresses>[].obs;
  final RxList<String> addressesError = <String>[].obs;
  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }
  void fetchAddresses() async{
    try {
      var addresses = await RemoteServicesAddresses.fetchAddresses();
      addressesList.value = addresses;
      addressesError.clear();
    } catch (error) {
      addressesError.add(error.toString());
    } finally {
      update();
    }

  }
}