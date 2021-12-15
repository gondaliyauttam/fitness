import 'package:fitness/api/model/cat_control.dart';
import 'package:fitness/api/service_class/category_service_class.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  List<CategoriesModel> getCats = [];

  CategoryServices services = CategoryServices();
  var postloading = true.obs;
  @override
  void onInit() {
    callCategories();

    super.onInit();
  }

  callCategories() async {
    print('1');
    try {
      postloading.value = true;
      var result = await services.getCategories();
      if (result != null) {
        getCats.assignAll(result);
      } else {
        print("null");
      }
    } finally {
      postloading.value = false;
    }
    update();
  }
}
