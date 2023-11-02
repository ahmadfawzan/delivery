import 'package:get/get.dart';
import '../../model/categories_model/categories_model.dart';
import '../../services/categories/get_categories/get_categories.dart';

class CategoriesController extends GetxController {
  final RxList<Categories> categoriesList = <Categories>[].obs;
  final RxList<String> categoriesError = <String>[].obs;
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
  void fetchCategories() async{
    try{
      var categories= await RemoteServicesCategories.fetchCategories();
      categoriesList.value =categories;
      categoriesError.clear();
    }catch(error){
      categoriesError.add(error.toString());
    }finally{
      update();
    }

  }
}