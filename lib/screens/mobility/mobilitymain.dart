// import 'package:fitness/controller/catagories_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';

// class MobilityMain extends StatefulWidget {
//   const MobilityMain({Key? key}) : super(key: key);

//   @override
//   _MobilityMainState createState() => _MobilityMainState();
// }

// class _MobilityMainState extends State<MobilityMain> {
//   var catController = Get.put(CategoriesController());

//   @override
//   void initState() {
//     print('all videos lib');
//     Get.put(CategoriesController());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () {
//           return catController.postloading.value
//               ? Center(
//                   child: Image.network(
//                       'https://cdn.dribbble.com/users/26878/screenshots/3544693/07-loader.gif'),
//                 )
//               : catController.getCats.isEmpty
//                   ? const Center(
//                       child: Text(
//                         "No Data Found..",
//                       ),
//                     )
//                   : StaggeredGridView.countBuilder(
//                       crossAxisCount: 2,
//                       itemCount: catController.getCats.length,
//                       itemBuilder: (BuildContext context, int index) => Stack(
//                         fit: StackFit.expand,
//                         alignment: AlignmentDirectional.center,
//                         children: <Widget>[
//                           ClipRRect(
//                             child: Image.network(
//                               'http://fitness.kriyaninfotech.com/public/subcategory/' +
//                                   catController.getCats[index].image.toString(),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   catController.getCats[index].name.toString(),
//                                   style: const TextStyle(
//                                     color: Color(0xFFC98506),
//                                     fontFamily: 'Montserrat',
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 32,
//                                   ),
//                                 ),
//                               ])
//                         ],
//                       ),
//                       staggeredTileBuilder: (int index) =>
//                           const StaggeredTile.count(2, 1),
//                       mainAxisSpacing: 4.0,
//                       crossAxisSpacing: 4.0,
//                     );
//         },
//       ),
//     );
//   }
// }

import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/search/search.dart';
import 'package:fitness/screens/userprofile/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitness/api/services/api.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MobilityMain extends StatefulWidget {
  final String? page;
  final String? cat_id;

  const MobilityMain({Key? key, required this.page, required this.cat_id})
      : super(key: key);

  @override
  _MobilityMainState createState() => _MobilityMainState();
}

class _MobilityMainState extends State<MobilityMain> {
  List allVideos = [];
  String? id;

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
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Wrap(children: [
        //       IconButton(
        //           onPressed: () {
        //             Get.back();
        //           },
        //           icon: const Icon(Icons.arrow_back_ios)),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 10),
        //         child: Text(
        //           widget.page.toString(),
        //           style: const TextStyle(
        //               color: Color(0xff777777),
        //               fontFamily: 'Montserrat',
        //               fontWeight: FontWeight.bold,
        //               fontSize: 22),
        //         ),
        //       ),
        //     ]),
        //     Flexible(
        //       child: Padding(
        //         padding: const EdgeInsets.only(right: 10),
        //         child: GestureDetector(
        //           onTap: () {
        //             Get.to(() => const MainDashBoard());
        //           },
        //           child: ClipRRect(
        //             clipBehavior: Clip.antiAliasWithSaveLayer,
        //             child: Image.asset(
        //               'assets/signin_logo.png',
        //               width: 120,
        //               height: 70,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        body: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: allVideos.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
            highlightColor: Colors.green[200],
            onTap: () {},
            child: Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        // height: 100,
                        width: double.infinity,
                        child: ClipRRect(
                          child: Image.network(
                            'http://fitness.kriyaninfotech.com/public/subcategory/' +
                                allVideos[index]['image'],
                            width: 120,
                            height: 70,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
          ),
          staggeredTileBuilder: (int index) => const StaggeredTile.count(2, 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
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
      // "category_id": widget.cat_id.toString(),
      // "type": "1,2"
    };
    var response = await http.post(
      Uri.parse(ApiService.allvideos),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        allVideos = convert.jsonDecode(response.body)['data']["categoryVideos"];
      });
    } else {
      allVideos = [];
    }
  }
}
