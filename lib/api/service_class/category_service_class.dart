import 'dart:async';
import 'dart:convert' as convert;

import 'package:fitness/api/services/api.dart';
import 'package:fitness/api/model/cat_control.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryServices {
  String? id;

  Future<List<CategoriesModel>?> getCategories() async {
    print('2');

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("id")!.toString();
      Map data = {"user_id": id, "type": '1'};
      var response = await http.post(
        Uri.parse(ApiService.dashBoard),
        body: data,
      );
      print(response.body);

      if (response.statusCode == 200) {
        List jsonresponse =
            convert.jsonDecode(response.body)['data']['categories'];
        print(response.body);
        return jsonresponse.map((e) => CategoriesModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  Future<List<CategoriesModel>?> getTrainers() async {
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
        List jsonresponse =
            convert.jsonDecode(response.body)['data']['trainers'];
        print(response.body);
        return jsonresponse.map((e) => CategoriesModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }
}
