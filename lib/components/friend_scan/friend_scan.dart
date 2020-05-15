import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tog3ther/pages/qr_scan_page/qr_scan_page.dart';

import '../../theme.dart';

class FriendScan extends StatefulWidget {
  FriendScan({Key key}) : super(key: key);

  @override
  _FriendScanState createState() => _FriendScanState();
}

class _FriendScanState extends State<FriendScan> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: TogetherTheme.cardShape,
      elevation: TogetherTheme.cardElevation,
      shadowColor: Colors.blue.withOpacity(0.6),
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QrScanPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 100,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Freundescode",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.white
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                    ),
                    Text(
                      "scannen",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Icon(
                  MaterialCommunityIcons.qrcode,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
