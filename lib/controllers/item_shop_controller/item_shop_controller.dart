import 'package:delivery/controllers/shop_controller/shop_controller.dart';
import 'package:get/get.dart';
import '../../models/item_shop_model/item_shop_model.dart';
import '../../services/item_shop/get_item_shop/get_item_shop.dart';

class ItemShopController extends GetxController{
  final ShopController shopController = Get.find();
  var isLoading=true.obs;
  final RxList<ItemShop> itemShopList = <ItemShop>[].obs;
  final RxList<String> itemShopError = <String>[].obs;
  List itemShopSearch=[].obs;
  RxString searchText = ''.obs;
  int? id;
  @override
  void onInit() {
    fetchItemShop();
    super.onInit();
  }

  void fetchItemShop() async{
    try {
      var itemShop = await RemoteServicesItemShop.fetchItemShop();
      itemShopList.value= itemShop.where((element) => element.pivot?.shopId == shopController.id && searchText.isEmpty).toList();
      itemShopError.clear();
    } catch (error) {
      itemShopError.add(error.toString());
    } finally {
      update();
      isLoading(false);
    }
  }


  Future SearchitemShop() async {
    itemShopSearch = itemShopList
        .where((element) =>
        element.title!.en!.contains(searchText.toString()) &&
            searchText.isNotEmpty)
        .toList();
    update();
  }
}
