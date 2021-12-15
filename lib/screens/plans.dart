import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard/main_dashboard.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'ABOUT US',
                    style: TextStyle(
                        color: Color(0xff777777),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
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
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
              "To put it simply, physical activity and exercise is important for everyone. Children, adolescents, and adults of all ages need regular physical activity. Physical activity promotes good health, and you should stay active throughout all stages of your life regardless of your body type or BMIUnderstanding the benefits of physical fitness and knowing how active you should be can help you maintain good health and improve your overall quality of life. Here are a few benefits of regular physical activity that demonstrate the importance of physical fitness.Save moneyAccording to the Centers for Disease Control and Prevention, chronic diseases cause 7 out of 10 deaths in the U.S., and treating chronic diseases accounts for 86% of U.S. healthcare costs. While some diseases cannot be prevented, you can reduce your risk for certain disease – such as heart disease and diabetes – through reducing risky behaviors and living a healthy lifestyle.Making healthy choices, such as engaging in regular physical activity, can reduce your risk for many health issues and complications that can result in expensive medical care.Increase your life expectancyNumerous studies have shown that regular physical activity increases life expectancy and reduces the risk of premature mortality. There’s not a magic formula that translates hours of physical activity into hours of life gained, but research suggests that people who are more active tend to be healthier and tend to live longer.Reduce your risk of injuryRegular exercise and physical activity increase muscle strength, bone density, flexibility, and stability. Physical fitness can reduce your risk for and resilience to accidental injuries, especially as you get older. For example, stronger muscles and better balance mean that you’re less likely to slip and fall, and stronger bones mean that your less likely to suffer bone injuries should you take a tumble.Improve your quality of lifeA sedentary lifestyle and a lack of physical activity can take a toll on a person’s body. Physical inactivity is associated with an increased risk for certain types of cancer, numerous chronic diseases, and mental health issues. Exercise, however, has been shown to improve mood and mental health, and provides numerous health benefits. Of course physical fitness also allows you to do things that you may not otherwise be able to do.Stay activeStaying active and healthy allows you to do activities that require a certain level of physical fitness. For example, hiking to the top of a mountain is a rewarding experience that instills a sense of accomplishment and provides spectacular scenery, but there are people who cannot experience this due to fitness limitations."),
        ),
      ),
    );
  }
}
