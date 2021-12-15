import 'package:fitness/controller/catagories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class MobilityMid extends StatefulWidget {
  const MobilityMid({Key? key}) : super(key: key);

  @override
  _MobilityMidState createState() => _MobilityMidState();
}

class _MobilityMidState extends State<MobilityMid> {
  var catController = Get.put(CategoriesController());

  @override
  void initState() {
    Get.put(CategoriesController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return catController.postloading.value
              ? Center(
                  child: Image.network(
                      'https://cdn.dribbble.com/users/26878/screenshots/3544693/07-loader.gif'),
                )
              : catController.getCats.isEmpty
                  ? const Center(
                      child: Text(
                        "No Data Found..",
                      ),
                    )
                  : StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: catController.getCats.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        child: Stack(
                          // fit: StackFit.loose,
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            ClipRRect(
                              child: Image.network(
                                catController.getCats[index].image.toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    catController.getCats[index].name
                                        .toString(),
                                    style: const TextStyle(
                                      color: Color(0xFFC98506),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(1, index.isEven ? 1.25 : .5),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    );
        },
      ),
    );
  }
}
