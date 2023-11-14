import 'package:get/get.dart';
import '../../models/categorie_model/categorie_model.dart';
import '../../services/categorie/get_categorie/get_categorie.dart';


class CategorieController extends GetxController {
  var isLoading=true.obs;
  final RxList<Categorie> categorieList = <Categorie>[].obs;
  final RxList<String> categorieError = <String>[].obs;
  int? id;
  String? title;
  num? expeditedFees;
  num? deliveryFee;
  num? commesion;
  String? popMenuValue;
  @override
  void onInit() {
    fetchCategorie();
    super.onInit();
  }
  void fetchCategorie() async{
    try{
      var categorie= await RemoteServicesCategorie.fetchCategorie();
      categorieList.value =categorie;
      categorieError.clear();
    }catch(error){
      categorieError.add(error.toString());
    }finally{
      update();
      isLoading(false);
    }

  }
}