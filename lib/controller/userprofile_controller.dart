import 'package:fitness/api/model/user_profile_model.dart';

import 'package:fitness/api/service_class/user_profile_service.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  List<UserProfileModel> getUserProfile = [];

  UserProfileServices services = UserProfileServices();
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
      var result = await services.getUserProfile();
      if (result != null) {
        getUserProfile.assignAll(result);
      } else {
        print("null");
      }
    } finally {
      postloading.value = false;
    }
    update();
  }
}
