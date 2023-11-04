import 'package:get/get.dart';
import '../../models/shop_model/shop_model.dart';
import '../../services/shop/get_shop.dart';
import '../categorie_controller/categorie_controller.dart';

class ShopController extends GetxController{
  final CategorieController categorieController = Get.find();
  var isLoading=true.obs;
  final RxList<Shop> shopList = <Shop>[].obs;
  final RxList<String> shopError = <String>[].obs;
  List shopsItemList=[].obs;
  RxString searchText = ''.obs;

  @override
  void onInit() {
    fetchShop();
    super.onInit();
  }

  void fetchShop() async{
    try {
      var shop = await RemoteServicesShop.fetchShop();
      shopList.value= shop;
      shopError.clear();
    } catch (error) {
      shopError.add(error.toString());
    } finally {
      update();
      isLoading(false);
    }
  }


  Future SearchShop() async {
    shopsItemList = shopList
        .where((element) =>
    element.categoryId == categorieController.id &&
        searchText.isEmpty ||
        element.shopNameEn!.contains(searchText.toString()) &&
            searchText.isNotEmpty)
        .toList();
     update();
  }
}

