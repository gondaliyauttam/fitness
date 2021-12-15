// import 'package:fitness/api/services/api.dart';
// import 'package:fitness/screens/dashboard/main_dashboard.dart';
// import 'package:fitness/screens/userprofile/setting.dart';
// import 'package:fitness/screens/wod/video_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// class Search extends StatefulWidget {
//   const Search({Key? key}) : super(key: key);

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   String? id, query;
//   List searchCatList = [];
//   List searchTotalList = [];
//   var results = [];
//   List dog = [];
//   var dog1 = [];

//   TextEditingController searchText = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(90),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Wrap(children: [
//                 IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: const Icon(Icons.arrow_back_ios)),
//                 const Hero(
//                   tag: 'search',
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 10),
//                     child: Text(
//                       'SEARCH',
//                       style: TextStyle(
//                           color: Color(0xff777777),
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22),
//                     ),
//                   ),
//                 ),
//               ]),
//               Flexible(
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(() => const MainDashBoard());
//                     },
//                     child: ClipRRect(
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       child: Image.asset(
//                         'assets/signin_logo.png',
//                         width: 120,
//                         height: 70,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(children: [
//             // Container(
//             //   height: 50,
//             //   padding: const EdgeInsets.all(8),
//             //   child: TextField(
//             //     // onChanged: onTextChange,
//             //     decoration: InputDecoration(
//             //         fillColor: Colors.black.withOpacity(0.1),
//             //         filled: true,
//             //         prefixIcon: const Icon(Icons.search),
//             //         hintText: 'Search something ...',
//             //         border: OutlineInputBorder(
//             //             borderRadius: BorderRadius.circular(10),
//             //             borderSide: BorderSide.none),
//             //         contentPadding: EdgeInsets.zero),
//             //   ),
//             // ),
//             TextFormField(
//               maxLines: 1,
//               controller: searchText,
//               onChanged: (v) {
//                 setState(() {
//                   query = v;
//                   if (query!.length > 3) {
//                     getSearh(query);
//                     setResults(query);
//                   } else {}
//                 });
//               },
//               decoration: InputDecoration(
//                   fillColor: Colors.black.withOpacity(0.1),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     borderSide: BorderSide(width: 1, color: Colors.grey[50]!),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     borderSide: BorderSide(width: 1, color: Colors.grey[50]!),
//                   ),
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         searchText.clear();
//                         searchCatList == [];
//                       });
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.only(top: 12),
//                       child: Text('clear'),
//                     ),
//                   ),
//                   filled: true,
//                   hintText: 'Search'),
//             ),
//             SizedBox(
//                 height: 20,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   itemCount: searchCatList.length,
//                   itemBuilder: (context, index) => InkWell(
//                     onTap: () {
//                       if (searchCatList[index]['name'] ==
//                           dog.contains(searchCatList[index]['name'])) {
//                         null;
//                       } else {
//                         setState(() {
//                           dog.add({"name": searchCatList[index]['name']});
//                         });
//                       }
//                     },
//                     child: Text(
//                       searchCatList[index]['name'],
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 )),
//             SizedBox(
//               height: 50,
//               width: double.infinity,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: dog.length,
//                 itemBuilder: (context, index) {
//                   return SizedBox(
//                     width: 200,
//                     child: Card(
//                         child: ListTile(
//                       title: Text(dog[index]['name'].toString()),
//                     )),
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 getTotalSearch();
//               },
//               child: const Text('Search'),
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemCount: searchTotalList.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       if (searchTotalList[index]['video'] ==
//                           "http://fitness.kriyaninfotech.com/public/uploads/videos/") {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             backgroundColor: Colors.red,
//                             content: Text("Video Not Available"),
//                           ),
//                         );
//                       } else {
//                         Get.to(() => WodVideoScreen(
//                             video: searchTotalList[index]['video'].toString()));
//                       }
//                     },
//                     child: Card(
//                         child: SizedBox(
//                       height: 150,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: SizedBox(
//                               height: 150,
//                               width: 150,
//                               child: Image.network(
//                                 searchTotalList[index]['image'],
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Flexible(child: Text(searchTotalList[index]['name'])),
//                           const Icon(Icons.play_circle),
//                         ],
//                       ),
//                     )),
//                   );
//                 },
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }

//   Future<void> getSearh(query) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     id = pref.getString("id")!.toString();
//     print(id);
//     Map data = {"user_id": '65', "search_key": query, "type": '2'};
//     var response = await http.post(
//       Uri.parse(ApiService.dashBoard),
//       body: data,
//     );
//     print(response.body);
//     print(response.statusCode);

//     if (response.statusCode == 200) {
//       setState(() {
//         searchCatList = convert.jsonDecode(response.body)['data']['categories'];
//       });
//     } else {
//       searchCatList = [];
//     }
//   }

//   Future<void> getTotalSearch() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     id = pref.getString("id")!.toString();
//     print(id);
//     Map data = {
//       "user_id": '65',
//       "category_id": searchCatList.toString(),
//       "type": '2'
//     };
//     print(data.toString());

//     var response = await http.post(
//       Uri.parse(ApiService.searchCat),
//       body: data,
//     );
//     print(response.body);
//     print(response.statusCode);

//     if (response.statusCode == 200) {
//       setState(() {
//         searchTotalList =
//             convert.jsonDecode(response.body)['data']['categories'];
//       });
//     } else {
//       searchTotalList = [];
//     }
//   }

//   void setResults(query) {
//     results = searchCatList
//         .where(
//           (elem) => elem['name'].toString().toLowerCase().contains(
//                 query.toLowerCase(),
//               ),
//         )
//         .toList();
//   }
// }

import 'dart:convert';

import 'package:fitness/api/services/api.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/userprofile/setting.dart';
import 'package:fitness/screens/wod/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? id, query;
  List searchCatList = [];
  List searchTotalList = [];
  var results = [];
  List dog = [];
  var dog1 = [];
  var dog2 = [];
  var dog3 = [];
  var distinctIds;

  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Hero(
                  tag: 'search',
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'SEARCH',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
              ]),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const MainDashBoard());
                    },
                    child: ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        'assets/signin_logo.png',
                        width: 120,
                        height: 70,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // Container(
            //   height: 50,
            //   padding: const EdgeInsets.all(8),
            //   child: TextField(
            //     // onChanged: onTextChange,
            //     decoration: InputDecoration(
            //         fillColor: Colors.black.withOpacity(0.1),
            //         filled: true,
            //         prefixIcon: const Icon(Icons.search),
            //         hintText: 'Search something ...',
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             borderSide: BorderSide.none),
            //         contentPadding: EdgeInsets.zero),
            //   ),
            // ),
            TextFormField(
              maxLines: 1,
              controller: searchText,
              onChanged: (v) {
                setState(() {
                  query = v;
                  if (query!.length > 3) {
                    getSearh(query);
                    setResults(query);
                  } else if (query!.isEmpty) {
                    setState(() {
                      searchCatList == [];
                    });
                  }
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.black.withOpacity(0.1),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1, color: Colors.grey[50]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1, color: Colors.grey[50]!),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        searchText.clear();
                        searchCatList == [];
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text('clear'),
                    ),
                  ),
                  filled: true,
                  hintText: 'Search'),
            ),
            SizedBox(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: searchCatList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        dog.add(searchCatList[index]['name']);
                        dog2.add(searchCatList[index]['id']);
                        final jsonList =
                            dog.map((item) => jsonEncode(item)).toList();
                        final uniqueJsonList = jsonList.toSet().toList();
                        dog1 = uniqueJsonList
                            .map((item) => jsonDecode(item))
                            .toList();

                        final jsonList1 =
                            dog2.map((item) => jsonEncode(item)).toList();
                        final uniqueJsonList1 = jsonList1.toSet().toList();
                        dog3 = uniqueJsonList1
                            .map((item) => jsonDecode(item))
                            .toList();
                        print(dog3);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        searchCatList[index]['name'],
                        style: const TextStyle(
                            color: Color(0xff777777),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dog1.length,
                itemBuilder: (context, index) {
                  print(dog1.length);
                  return Container(
                    alignment: Alignment.center,
                    width: 140,
                    child: Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(dog1[index].toString(),
                            style: const TextStyle(
                                color: Color(0xff777777),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getTotalSearch();
              },
              child: const Text('Search',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: searchTotalList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (searchTotalList[index]['video'] ==
                          "http://fitness.kriyaninfotech.com/public/uploads/videos/") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Video Not Available"),
                          ),
                        );
                      } else {
                        Get.to(() => WodVideoScreen(
                            video: searchTotalList[index]['video'].toString()));
                      }
                    },
                    child: Card(
                        child: SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.network(
                                searchTotalList[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(child: Text(searchTotalList[index]['name'])),
                          const Icon(Icons.play_circle),
                        ],
                      ),
                    )),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> getSearh(query) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(id);
    Map data = {"user_id": id, "search_key": query, "type": '2'};
    var response = await http.post(
      Uri.parse(ApiService.dashBoard),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        searchCatList = convert.jsonDecode(response.body)['data']['categories'];
      });
    } else {
      searchCatList = [];
    }
  }

  Future<void> getTotalSearch() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(dog3);
    var ss = dog3.toString().replaceAll("[", "").replaceAll("]", "");
    print(ss);
    Map data = {"user_id": id, "category_id": ss.toString(), "type": '2'};
    print(data.toString());

    var response = await http.post(
      Uri.parse(ApiService.searchCat),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        searchTotalList =
            convert.jsonDecode(response.body)['data']['categories'];
      });
    } else {
      searchTotalList = [];
    }
  }

  void setResults(query) {
    results = searchCatList
        .where(
          (elem) => elem['name'].toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }
}
