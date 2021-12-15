import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_rave/flutter_rave.dart';

class Payment extends StatefulWidget {
  Payment({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
                    'PAYMENT',
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
        body: Center(
          child: Builder(
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: InkWell(
                  // onTap: () => _pay(context),
                  child: Card(
                    color: Colors.orangeAccent,
                    elevation: 15,
                    child: SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Card Payment",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.payment,
                              color: Colors.black,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // _pay(BuildContext context) {
  //   final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
  //   final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
  //   final _rave = RaveCardPayment(
  //     isDemo: true,
  //     encKey: "c53e399709de57d42e2e36ca",
  //     publicKey: "FLWPUBK-d97d92534644f21f8c50802f0ff44e02-X",
  //     transactionRef: "hvHPvKYaRuJLlJWSPWGGKUyaAfWeZKnm",
  //     amount: 100,
  //     email: "demo1@example.com",
  //     onSuccess: (response) {
  //       print("$response");
  //       print("Transaction Successful");
  //       if (mounted) {
  //         Scaffold.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("Transaction Sucessful!"),
  //             backgroundColor: Colors.green,
  //             duration: Duration(
  //               seconds: 5,
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //     onFailure: (err) {
  //       print("$err");
  //       print("Transaction failed");
  //       Scaffold.of(context).showSnackBar(snackBar_onFailure);
  //     },
  //     onClosed: () {
  //       print("Transaction closed");
  //       Scaffold.of(context).showSnackBar(snackBar_onClosed);
  //     },
  //     context: context,
  //   );
  //   _rave.process();
  // }
}
