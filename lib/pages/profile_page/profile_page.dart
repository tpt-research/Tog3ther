import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tog3ther/animations/show_up/show_up.dart';
import 'package:tog3ther/model/friend/friend.dart';
import 'package:tog3ther/pages/search_page/search_page.dart';
import 'package:uuid/uuid.dart';

import '../../theme.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getProfile().then((value) async {
      await Future.delayed(Duration(seconds: 1));
      if (value != null) {
        await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfileEdit(friend: value, isEdit: true)), (route) => route.isFirst);
      } else {
        await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfileEdit(friend: value, isEdit: false)), (route) => route.isFirst);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        ),
      )
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

class ProfileEdit extends StatefulWidget {
  ProfileEdit({Key key, this.friend, this.isEdit}) : super(key: key);

  final FriendElement friend;
  final bool isEdit;

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  FriendElement globalFriendElement = FriendElement();
  TextEditingController _descriptionTextController = TextEditingController();

  Color color = Colors.blue;
  IconData icon = Icons.person;

  @override
  void initState() {
    super.initState();

    if (widget.friend != null) {
      globalFriendElement = widget.friend;
      _descriptionTextController.text = widget.friend.name;
      icon = IconData(
          widget.friend.iconCodepoint,
          fontFamily: 'MaterialIcons'
      );

      // Reset Color
      color = Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profil bearbeiten",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            ShowUp(
              delay: 100,
              child: Card(
                shape: TogetherTheme.cardShape,
                elevation: TogetherTheme.cardElevation,
                shadowColor: Colors.grey.withOpacity(0.6),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.grey
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.75,
                            child: TextField(
                              controller: _descriptionTextController,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              enableInteractiveSelection: true,
                              autofocus: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: "Name eingeben",
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20
                              ),
                              toolbarOptions: ToolbarOptions(copy: true),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                        ],
                      ),
                      Icon(
                          Icons.location_on
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            ShowUp(
              delay: 200,
              child: Card(
                shape: TogetherTheme.cardShape,
                elevation: TogetherTheme.cardElevation,
                shadowColor: Colors.grey.withOpacity(0.6),
                child: InkWell(
                  onTap: () async {
                    var result = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchPage()));

                    if (result != null) {
                      setState(() {
                        globalFriendElement.feature = result;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Haltestelle in der Nähe",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                            ),
                            Text(
                              globalFriendElement.feature == null
                                  ? "Bitte hier eingeben"
                                  : globalFriendElement.feature.properties.name,
                              style: TextStyle(
                                  fontWeight: globalFriendElement.feature == null
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  color: globalFriendElement.feature == null
                                      ? Colors.grey
                                      : Colors.black,
                                  fontSize: 20
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                            ),
                          ],
                        ),
                        Icon(
                            Icons.location_on
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ShowUp(
              delay: 300,
              child: Theme(
                data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent
                ),
                child: Card(
                  shape: TogetherTheme.cardShape,
                  semanticContainer: true,
                  child: ExpansionTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.map,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                        ),
                        Text(
                          "Karte anzeigen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: FlutterMap(
                            options: new MapOptions(
                                center: globalFriendElement.feature == null
                                    ? LatLng(51.5, -0.09)
                                    : LatLng(globalFriendElement.feature.geometry
                                    .coordinates[1],
                                    globalFriendElement.feature.geometry
                                        .coordinates[0]),
                                zoom: 13.0,
                                maxZoom: 17.0
                            ),
                            layers: [
                              new TileLayerOptions(
                                  urlTemplate: "http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c']
                              ),
                              if (globalFriendElement.feature != null)
                                new MarkerLayerOptions(
                                    markers: <Marker>[
                                      Marker(
                                          point: LatLng(
                                              globalFriendElement.feature.geometry
                                                  .coordinates[1],
                                              globalFriendElement.feature.geometry
                                                  .coordinates[0]),
                                          builder: (context) {
                                            return CircleAvatar(
                                              backgroundColor: Colors.black,
                                              child: Icon(
                                                Icons.directions_bus,
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                      )
                                    ]
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            ShowUp(
              delay: 400,
              child: Card(
                shape: TogetherTheme.cardShape,
                child: ListTile(
                  leading: Icon(
                    Ionicons.ios_color_fill,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Farbe",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  trailing: DropdownButton<Color>(
                    value: color,
                    icon: Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.arrow_downward)
                    ),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (Color newValue) {
                      setState(() {
                        color = newValue;
                      });
                    },
                    items: <Color>[
                      Colors.blue,
                      Colors.pink,
                      Colors.red,
                      Colors.green,
                      Colors.black
                    ]
                        .map<DropdownMenuItem<Color>>((Color selectedColor) {
                      return DropdownMenuItem<Color>(
                        value: selectedColor,
                        child: CircleAvatar(
                          backgroundColor: selectedColor,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            ShowUp(
              delay: 500,
              child: Card(
                shape: TogetherTheme.cardShape,
                child: ListTile(
                  leading: Icon(
                    MaterialCommunityIcons.emoticon,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Icon",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  trailing: DropdownButton<IconData>(
                    value: icon,
                    icon: Container(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.arrow_downward)
                    ),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (IconData newValue) {
                      setState(() {
                        icon = newValue;
                      });
                    },
                    items: <IconData>[
                      Icons.person,
                      Icons.directions_bus,
                      Icons.headset,
                    ]
                        .map<DropdownMenuItem<IconData>>((IconData selectedIcon) {
                      return DropdownMenuItem<IconData>(
                        value: selectedIcon,
                        child: CircleAvatar(
                          backgroundColor: color,
                          child: Icon(
                            selectedIcon,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ShowUp(
        delay: 600,
        child: FloatingActionButton(
          onPressed: () async {
            finalizeFriendElement();

            if (globalFriendElement.name == null) {
              showToast('Speichern fehlgeschlagen! Name fehlt.');
              return null;
            }

            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setString('profile', globalFriendElement.toRawJson());
            showToast('Speichern abgeschlossen!');


            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Icon(
              Icons.save
          ),
        ),
      ),
    );
  }

  finalizeFriendElement() {
    var uuid = Uuid();

    globalFriendElement.color = color.value;
    globalFriendElement.name = _descriptionTextController.text;
    globalFriendElement.iconCodepoint = icon.codePoint;
    if (widget.isEdit != true) {
      globalFriendElement.id = uuid.v4();
    }
  }
}

