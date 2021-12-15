import 'package:fitness/controller/catagories_controller.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';

import 'package:fitness/screens/mobility/mobility_caty.dart';
import 'package:fitness/screens/mobility/mobility_lib.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobilityDashBoard extends StatefulWidget {
  const MobilityDashBoard({Key? key}) : super(key: key);

  @override
  State<MobilityDashBoard> createState() => _MobilityDashBoardState();
}

class _MobilityDashBoardState extends State<MobilityDashBoard> {
  // var catController = Get.put(CategoriesController);

  String? id;
  List mobCatList = [];

  @override
  void initState() {
    super.initState();
  }

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
          //             'MOBILITY',
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
          body: Center(
        child: Container(
          height: 680,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(
              'assets/cd_logo.png',
            ),
          )),
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 530,
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 50,
                      left: 5,
                      height: 150,
                      width: 250,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => const MobilityLibrary(
                              page: 'LIBRARY',
                              cat_id: '',
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'wod',
                          child: Card(
                            color: Colors.white70,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(1.0),
                              ),
                            ),
                            elevation: 5,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1.0),
                                  child: Image.network(
                                    'http://fitness.kriyaninfotech.com/public/category/' +
                                        Get.put(CategoriesController())
                                            .getCats[2]
                                            .image
                                            .toString(),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                const Text(
                                  'LIBRARY',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
                    Positioned(
                      top: 260,
                      left: 180,
                      width: 200,
                      height: 150,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const MobilityCategories());
                        },
                        child: Hero(
                          tag: 'bpm',
                          child: Card(
                            color: Colors.white54,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(1.0),
                              ),
                            ),
                            elevation: 10,
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1.0),
                                    child: Image.network(
                                      'http://fitness.kriyaninfotech.com/public/category/' +
                                          Get.put(CategoriesController())
                                              .getCats[6]
                                              .image
                                              .toString(),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'CATEGORIES',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
