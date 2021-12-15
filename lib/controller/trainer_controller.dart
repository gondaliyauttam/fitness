import 'package:fitness/api/model/trainer_model.dart';
import 'package:fitness/api/service_class/trainer_services_class.dart';
import 'package:get/get.dart';

class TrainerController extends GetxController {
  List<TrainerModel> getTrainers = [];

  TrainerServices services = TrainerServices();
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
      var result = await services.getTrainers();
      if (result != null) {
        getTrainers.assignAll(result);
      } else {
        print("null");
      }
    } finally {
      postloading.value = false;
    }
    update();
  }
}
