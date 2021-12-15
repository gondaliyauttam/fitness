import 'dart:async';
import 'dart:convert' as convert;

import 'package:fitness/api/model/user_profile_model.dart';
import 'package:fitness/api/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileServices {
  String? id;

  Future<List<UserProfileModel>?> getUserProfile() async {
    print('2');

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("id")!.toString();
      Map data = {'user_id': id};
      var response = await http.post(
        Uri.parse(ApiService.personalTrainer),
        body: data,
      );
      print(response.body);

      if (response.statusCode == 200) {
        List jsonresponse = convert.jsonDecode(response.body)['data']['user'];
        print(response.body);
        return jsonresponse.map((e) => UserProfileModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }
}
