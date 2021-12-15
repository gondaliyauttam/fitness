// import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';

import 'package:fitness/screens/wod/video_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitness/api/services/api.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MobilityLibrary extends StatefulWidget {
  final String? page;
  final String? cat_id;

  const MobilityLibrary({Key? key, required this.page, required this.cat_id})
      : super(key: key);

  @override
  _MobilityLibraryState createState() => _MobilityLibraryState();
}

class _MobilityLibraryState extends State<MobilityLibrary> {
  List allVideos = [];
  String? id;
  bool isAppBar = true;

  @override
  void initState() {
    if (widget.page == 'CATEGORIES') {
      getallCatVideos();
    } else {
      getallLibraryVideos();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Column(children: const [
            SizedBox(
              height: 10,
            ),
            Text(
              'LIBRARY',
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
        body: SizedBox(
          child: ListView.builder(
            itemCount: allVideos.length,
            // itemExtent: 150,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (allVideos[index]['video'] ==
                    "http://fitness.kriyaninfotech.com/public/uploads/videos/") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Video Not Available"),
                    ),
                  );
                } else {
                  Get.to(
                    () => WodVideoScreen(
                      video:
                          'http://fitness.kriyaninfotech.com/public/uploads/' +
                              allVideos[index]['video'].toString(),
                    ),
                  );
                }
              },
              child: Card(
                  child: SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Flexible(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.network(
                            'http://fitness.kriyaninfotech.com/public/subcategory/' +
                                allVideos[index]['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Flexible(child: Text(allVideos[index]['slug'])),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.play_circle),
                    ),
                  ],
                ),
              )),
            ),
            // itemCount: 4,
          ),
        ),

        // StaggeredGridView.countBuilder(
        //   crossAxisCount: 2,
        //   itemCount: allVideos.length,
        //   itemBuilder: (BuildContext context, int index) => InkWell(
        //     highlightColor: Colors.green[200],
        //     onTap: () {},
        //     child: Card(
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Expanded(
        //               child: SizedBox(
        //                 // height: 100,
        //                 width: double.infinity,
        //                 child: ClipRRect(
        //                   child: Image.network(
        //                     allVideos[index]['image'],
        //                     width: 120,
        //                     height: 70,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //           ]),
        //     ),
        //   ),
        //   staggeredTileBuilder: (int index) =>
        //       StaggeredTile.count(1, index.isEven ? 1 : 0.75),
        //   mainAxisSpacing: 4.0,
        //   crossAxisSpacing: 4.0,
        // ),
      ),
    );
  }

  Future<void> getallCatVideos() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(id);
    Map data = {
      "user_id": id,
      "category_id": widget.cat_id.toString(),
      "type": "1,2"
    };
    var response = await http.post(
      Uri.parse(ApiService.subCategories),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        allVideos = convert.jsonDecode(response.body)['data']['categories'];
      });
    } else {
      allVideos = [];
    }
  }

  Future<void> getallLibraryVideos() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(id);
    Map data = {
      "user_id": id,
    };
    var response = await http.post(
      Uri.parse(ApiService.allvideos),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        allVideos = convert.jsonDecode(response.body)['data']['categoryVideos'];
      });
    } else {
      allVideos = [];
    }
  }
}
