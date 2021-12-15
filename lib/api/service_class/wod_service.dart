import 'dart:async';
import 'dart:convert' as convert;

import 'package:fitness/api/model/wod_model.dart';
import 'package:fitness/api/services/api.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WodServices {
  String? id;

  Future<List<WodModel>?> getWods() async {
    print('2');

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("id")!.toString();
      Map data = {'user_id': id};
      var response = await http.post(
        Uri.parse(ApiService.wod),
        body: data,
      );
      print(response.body);

      if (response.statusCode == 200) {
        List jsonresponse = convert.jsonDecode(response.body)['data']['wods'];
        print(response.body);
        return jsonresponse.map((e) => WodModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }
}
