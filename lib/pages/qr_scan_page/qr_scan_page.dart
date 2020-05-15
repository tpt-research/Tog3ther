import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/flutter_qr_bar_scanner.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tog3ther/model/friend/friend.dart';
import 'package:tog3ther/pages/create_friend_page/create_friend_page.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({Key key}) : super(key: key);

  @override
  _QrScanPageState createState() => new _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "QR-Freundescode scannen",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      body: Center(
        child: SizedBox(
          height: 1000,
          width: 500,
          child: QRBarScannerCamera(
            formats: [
              BarcodeFormats.AZTEC
            ],
            onError: (context, error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) async {
              try {
                var result = FriendElement.fromJson(jsonDecode(code));
                await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateFriendPage(
                  friend: result,
                  isEdit: false,
                  isScan: true,
                )));
              } catch(e) {
                print(code);
                showToast('QR-Code Scan fehlgeschlagen');
              }
            },
          ),
        ),
      )
    );
  }
}
