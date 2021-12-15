import 'package:fitness/api/model/wod_model.dart';

import 'package:fitness/api/service_class/wod_service.dart';
import 'package:get/get.dart';

class WodController extends GetxController {
  List<WodModel> getWods = [];

  WodServices services = WodServices();
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
      var result = await services.getWods();
      if (result != null) {
        getWods.assignAll(result);
      } else {
        print("null");
      }
    } finally {
      postloading.value = false;
    }
    update();
  }
}
