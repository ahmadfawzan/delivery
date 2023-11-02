import 'package:get/get.dart';
import '../../controllers/categories_controller/categories_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
  Get.put(CategoriesController(),permanent: true);
  }
}