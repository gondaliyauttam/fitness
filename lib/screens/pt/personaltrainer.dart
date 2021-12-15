import 'package:fitness/controller/trainer_controller.dart';
import 'package:fitness/payment.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalTrainer extends StatefulWidget {
  const PersonalTrainer({Key? key}) : super(key: key);

  @override
  State<PersonalTrainer> createState() => _PersonalTrainerState();
}

class _PersonalTrainerState extends State<PersonalTrainer> {
  final trainController = Get.put(TrainerController());
  @override
  void initState() {
    Get.put(TrainerController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Obx(() {
          return trainController.postloading.value
              ? Center(
                  child: Image.network(
                      'https://cdn.dribbble.com/users/26878/screenshots/3544693/07-loader.gif'),
                )
              : trainController.getTrainers.isEmpty
                  ? const Center(
                      child: Text(
                        "No Data Found..",
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                              const Hero(
                                tag: 'pt',
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'PERSONAL TRAINER',
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
                        SizedBox(
                          height: 700,
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: trainController.getTrainers.length,
                            itemBuilder: (BuildContext context, int index) =>
                                InkWell(
                              highlightColor: Colors.green[200],
                              onTap: () {
                                Get.to(() => Payment(
                                      title: 'Payment',
                                    ));
                              },
                              child: Card(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          // height: 100,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            child: Image.network(
                                                'http://fitness.kriyaninfotech.com/public/users/' +
                                                    trainController
                                                        .getTrainers[index]
                                                        .image
                                                        .toString(),
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      columnWid(
                                          trainController
                                              .getTrainers[index].name
                                              .toString(),
                                          trainController
                                              .getTrainers[index].skills
                                              .toString()),
                                    ]),
                              ),
                            ),
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.count(1, index.isEven ? 1 : 0.75),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ]),
                    );
        }),
      ),
    );
  }

  Column columnWid(text1, text2) {
    return Column(
      children: [
        Text(
          text1,
          style: const TextStyle(
              color: Color(0xFF000000),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        const SizedBox(),
        Text(
          text2,
          style: const TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
