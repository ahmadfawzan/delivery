import 'package:get/get.dart';
import '../../controllers/categorie_controller/categorie_controller.dart';


class CategorieBinding implements Bindings{
  @override
  void dependencies() {
  Get.put(CategorieController(),permanent: true);
  }
}