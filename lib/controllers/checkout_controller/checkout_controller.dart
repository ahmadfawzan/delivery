import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/address_model/address_model.dart';
import '../address_controller/address_controller.dart';

class CheckOutController extends GetxController {
  final AddressController addressController = Get.find();
  final RxList<Address> changeAddressList = <Address>[].obs;
  List popMenuValueCheckOut = [];
  final RxString phoneNumber=''.obs;
  String dropDownValueForPayment = 'Cash';
  var itemPayment=[ 'Cash',
    'Wallet',];
  late int selectedPaymentValue=1;
  Map<String, int> paymentOptions = {
    'Cash': 1,
    'Wallet': 2,
  };
  late String selectedDate=DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)));
  late List<String> itemDate  = [
    for (int i = 0; i < 7; i++) DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: i))),
  ];
  String selectedFromTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 12)));
  String selectedToTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 4)));
  List<String> hourList = [
  for (int hour = 1; hour <= 12; hour++) DateFormat('hh:mm a').format(DateTime.now().add(Duration(hours: hour))),
  ];
  @override
  void onInit() {
    sharedPreferencesPhone();
    super.onInit();
  }
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
    Future sharedPreferencesPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber.value = prefs.getString('PhoneNumber') ??'';
    update();
  }
}
