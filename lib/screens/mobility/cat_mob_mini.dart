import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/api/services/api.dart';
import 'package:fitness/screens/mobility/mobility_lib.dart';
import 'package:fitness/screens/search/search.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobilityCatMini extends StatefulWidget {
  const MobilityCatMini({Key? key}) : super(key: key);

  @override
  _MobilityCatMiniState createState() => _MobilityCatMiniState();
}

class _MobilityCatMiniState extends State<MobilityCatMini> {
  String? id;
  List mobCatList = [];

  @override
  void initState() {
    getMobCat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const Search());
          },
          child: const Icon(Icons.search),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Column(children: const [
            SizedBox(
              height: 10,
            ),
            Text(
              'CATEGORIES',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 27,
                color: Color(0xff777777),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ]),
        ),
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(80),
        //   child: Column(children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Wrap(children: [
        //           IconButton(
        //               onPressed: () {
        //                 Get.back();
        //               },
        //               icon: const Icon(Icons.arrow_back_ios)),
        //           const Padding(
        //             padding: EdgeInsets.only(top: 10),
        //             child: Text(
        //               'CATEGORIES',
        //               style: TextStyle(
        //                   color: Color(0xff777777),
        //                   fontFamily: 'Montserrat',
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 22),
        //             ),
        //           ),
        //         ]),
        //         Flexible(
        //           child: Padding(
        //             padding: const EdgeInsets.only(right: 10),
        //             child: GestureDetector(
        //               onTap: () {
        //                 Get.to(() => const MainDashBoard());
        //               },
        //               child: ClipRRect(
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 child: Image.asset(
        //                   'assets/signin_logo.png',
        //                   width: 120,
        //                   height: 70,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     // Container(
        //     //   height: 50,
        //     //   padding: const EdgeInsets.all(8),
        //     //   child: TextField(
        //     //     // onChanged: onTextChange,
        //     //     decoration: InputDecoration(
        //     //         fillColor: Colors.black.withOpacity(0.1),
        //     //         filled: true,
        //     //         prefixIcon: const Icon(Icons.search),
        //     //         hintText: 'Search something ...',
        //     //         border: OutlineInputBorder(
        //     //             borderRadius: BorderRadius.circular(10),
        //     //             borderSide: BorderSide.none),
        //     //         contentPadding: EdgeInsets.zero),
        //     //   ),
        //     // ),
        //   ]),
        // ),
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 3,
          itemCount: mobCatList.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
            highlightColor: Colors.green[200],
            onTap: () {
              Get.to(() => MobilityLibrary(
                  page: 'CATEGORIES',
                  cat_id: mobCatList[index]['id'].toString()));
            },
            child: Stack(
              fit: StackFit.expand,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ClipRRect(
                  child: Image.network(
                    'http://fitness.kriyaninfotech.com/public/category/' +
                        mobCatList[index]['image'],
                    // wodController.getWods[index].image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    mobCatList[index]['name'].toString(),
                    style: const TextStyle(
                      color: Color(0xFFE2D1B2),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ])
              ],
            ),
          ),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(1, index.isEven ? 0.75 : 0.25),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }

  Future<void> getMobCat() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(id);
    Map data = {"user_id": id, "type": '2'};

    var response = await http.post(
      Uri.parse(ApiService.dashBoard),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        mobCatList = convert.jsonDecode(response.body)['data']['categories'];
      });
    } else {
      mobCatList = [];
    }
  }
}
