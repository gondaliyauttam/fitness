import 'dart:developer';
import 'dart:io';

import 'package:fitness/api/services/api.dart';
import 'package:fitness/screens/userprofile/user_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class QRCode extends StatelessWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
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
                    tag: 'qr',
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'QR SCANNER',
                        style: TextStyle(
                            color: Color(0xff777777),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ]),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/qr.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const QRViewFunction());
                },
                child: const Text(
                  'SCAN QR',
                  style: TextStyle(
                      color: Color(0xff777777),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QRViewFunction extends StatefulWidget {
  const QRViewFunction({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewFunctionState();
}

class _QRViewFunctionState extends State<QRViewFunction> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid && Platform.isIOS) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    result != null
                        ? Text(result!.code.toString())
                        : Text("Scanning..."),

                    // if (result != null)
                    //   Text(
                    //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    // else
                    //   SizedBox(
                    //       height: 100,
                    //       width: 200,
                    //       child: const Text(
                    //         'Scan a code',
                    //         style: TextStyle(fontSize: 20),
                    //       )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Text('Flash: ${snapshot.data}');
                                },
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.flipCamera();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Text(
                                        'Camera facing ${describeEnum(snapshot.data!)}');
                                  } else {
                                    return const Text('loading');
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.pauseCamera();
                            },
                            child: const Text('pause',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.resumeCamera();
                            },
                            child: const Text('resume',
                                style: TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 500 ||
            MediaQuery.of(context).size.height < 500)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        gotoLogin(result!.code.toString());
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  String? id, type;

  void gotoLogin(String? result) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    type = pref.getString("type")!.toString();
    print(id);
    print(type);
    print("qrcode    " + result.toString());
    Map data = {
      "user_id": id,
      "qrcode": result.toString(),
    };
    var response = await http.post(
      Uri.parse(ApiService.qrLogin),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text("Login Successful"),
      //   ),
      // );
      Get.to(() => UserProfile(type1: type));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Scan Again"),
        ),
      );
    }
  }
}
