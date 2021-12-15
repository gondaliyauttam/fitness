import 'package:fitness/api/services/api.dart';
import 'package:fitness/controller/wod_controller.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/wod/wod_tai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class WodSmall extends StatefulWidget {
  const WodSmall({Key? key}) : super(key: key);

  @override
  _WodSmallState createState() => _WodSmallState();
}

class _WodSmallState extends State<WodSmall> {
  var wodController = Get.put(WodController());
  List wordvideoList = [];
  String? id;
  @override
  void initState() {
    // Get.put(WodController());
    getImageData();
    super.initState();
  }

  String? cat_splitag;
  var first_splitag;
  var first_splitag1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(100),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Wrap(children: [
        //         IconButton(
        //             onPressed: () {
        //               Get.back();
        //             },
        //             icon: const Icon(Icons.arrow_back_ios)),
        //         const Padding(
        //           padding: EdgeInsets.only(top: 10),
        //           child: Text(
        //             'WOD',
        //             style: TextStyle(
        //                 color: Color(0xff777777),
        //                 fontFamily: 'Montserrat',
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 22),
        //           ),
        //         ),
        //       ]),
        //       Flexible(
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 10),
        //           child: GestureDetector(
        //             onTap: () {
        //               Get.to(() => const MainDashBoard());
        //             },
        //             child: ClipRRect(
        //               clipBehavior: Clip.antiAliasWithSaveLayer,
        //               child: Image.asset(
        //                 'assets/signin_logo.png',
        //                 width: 120,
        //                 height: 70,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: Obx(
          () {
            print("efwkefhwiufhwuh " +
                wodController.postloading.value.toString());
            return wodController.postloading.value
                ? Center(
                    child: Image.network(
                        'https://cdn.dribbble.com/users/26878/screenshots/3544693/07-loader.gif'),
                  )
                : wodController.getWods.isEmpty
                    ? const Center(
                        child: Text(
                          "No Data Found..",
                        ),
                      )
                    : StaggeredGridView.countBuilder(
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(1, index.isEven ? 1 : 0.75),
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        crossAxisCount: 2,
                        itemCount: wodController.getWods.length,
                        itemBuilder: (BuildContext context, int index) {
                          cat_splitag =
                              wodController.getWods[index].createdAt.toString();
                          first_splitag = cat_splitag!.split("T");

                          first_splitag1 = first_splitag[0];
                          print(first_splitag1);
                          return Stack(
                            fit: StackFit.expand,
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => WodTai(
                                        date: wodController
                                            .getWods[index].createdAt
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  'http://fitness.kriyaninfotech.com/public/uploads/' +
                                      wodController.getWods[index].image,
                                  // wodController.getWods[index].image.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Text(
                                  convertDateTimeDisplay(
                                      first_splitag1.toString()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF4E3506),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
          },
        ),
      ),
    );
  }

  Future<void> getImageData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(id);
    Map data = {"user_id": id};
    var response = await http.post(
      Uri.parse(ApiService.wodDetails),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        wordvideoList = convert.jsonDecode(response.body)['data']['wordtitle'];
      });
    } else {
      wordvideoList = [];
    }
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
    final DateFormat serverFormater = DateFormat('dd MMMM yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
