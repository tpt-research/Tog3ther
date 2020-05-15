import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tog3ther/pages/add_friend_page/add_friend_page.dart';
import 'package:tog3ther/pages/create_place_page/create_place_page.dart';
import 'package:tog3ther/pages/friends_page/friends_page.dart';
import 'package:tog3ther/pages/oneway_page/oneway_page.dart';
import 'package:tog3ther/pages/places_page/places_page.dart';
import 'package:tog3ther/pages/profile_page/profile_page.dart';
import 'package:tog3ther/pages/settings_page/settings_page.dart';
import 'package:tog3ther/pages/twoway_page/twoway_page.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: 75,
                  child: Image.asset(
                      'assets/logo/logo_transparent_without_name.webp'
                  ),
                ),
                Text(
                  "Tog3ther",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5dacbd)
                  ),
                )
              ],
            ),
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16, bottom: 10),
                  child: Text(
                    'Suche'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Entypo.address,
                    color: Colors.green,
                  ),
                  title: Text(
                      'Einfache Suche'
                  ),
                  onTap: () => _open(OnewayPage()),
                ),
                ListTile(
                  leading: Icon(
                    MaterialCommunityIcons.wallet_travel,
                    color: Colors.orange,
                  ),
                  title: Text(
                    'Detailierte Suche'
                  ),
                  onTap: () => _open(TwowayPage()),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  child: Text(
                    'Social'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    MaterialCommunityIcons.account_heart_outline,
                    color: Colors.pink,
                  ),
                  title: Text(
                      'Freunde'
                  ),
                  onTap: () => _openWithModal(FriendsPage()),
                ),
                ListTile(
                  leading: Icon(
                    AntDesign.adduser,
                    color: Colors.cyan,
                  ),
                  title: Text(
                      'Freund hinzufügen'
                  ),
                  onTap: () => _openPush(AddFriendPage()),
                ),
                ListTile(
                  leading: Icon(
                    MaterialCommunityIcons.account_outline,
                    color: Colors.blue,
                  ),
                  title: Text(
                      'Profil bearbeiten'
                  ),
                  onTap: () => _openPush(ProfilePage()),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  child: Text(
                    'Pendler'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                      'Eigene Orte'
                  ),
                  onTap: () => _openWithModal(PlacesPage()),
                ),
                ListTile(
                  leading: Icon(
                    MaterialIcons.add_location,
                    color: Colors.indigo,
                  ),
                  title: Text(
                      'Ort hinzufügen'
                  ),
                  onTap: () => _openPush(CreatePlacePage(
                    isEdit: false
                  )),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  child: Text(
                    'Sonstiges'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: Text(
                      'Einstellungen'
                  ),
                  onTap: () => _openPush(SettingsPage()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _open(Widget page) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  _openPush(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  _openWithModal(Widget page) {
    Navigator.of(context).pushReplacement(MaterialWithModalsPageRoute(builder: (context) => page));
  }
}
