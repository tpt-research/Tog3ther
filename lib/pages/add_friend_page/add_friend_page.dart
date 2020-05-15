import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tog3ther/animations/show_up/show_up.dart';
import 'package:tog3ther/components/friend_manually/friend_manually.dart';
import 'package:tog3ther/components/friend_scan/friend_scan.dart';
import 'package:tog3ther/model/friend/friend.dart';
import 'package:tog3ther/pages/profile_page/profile_page.dart';

class AddFriendPage extends StatefulWidget {
  AddFriendPage({Key key}) : super(key: key);

  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Freund hinzufügen",
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
      body: ShowUp(
        delay: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  width: 250,
                  height: 250,
                  child: FutureBuilder<FriendElement>(
                    future: getProfile(),
                    builder: (BuildContext context, AsyncSnapshot<FriendElement> snapshot) {
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');

                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return CircularProgressIndicator();
                        case ConnectionState.done:
                          if (snapshot.data != null) {
                            return QrImage(
                              data: snapshot.data.toRawJson(),
                              version: QrVersions.auto,
                              size: 250.0,
                              errorCorrectionLevel: QrErrorCorrectLevel.H,
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Wir konnten keinen Freundescode erstellen, weil noch kein Profil angelegt ist.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
                                    },
                                    child: Text(
                                      "Profil anlegen"
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                Text(
                  "QR-Freundescode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            ShowUp(
              delay: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FriendScan(),
                  FriendManually()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<FriendElement> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var rawData = prefs.getString('profile');

    if (rawData == null) {
      return null;
    }

    return FriendElement.fromJson(jsonDecode(rawData));
  }
}
