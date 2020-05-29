import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tog3ther/model/friend/friend.dart';
import 'package:tog3ther/model/geojson/geojson.dart';
import 'package:tog3ther/services/hafas/hafas_service.dart';
import 'package:tog3ther/services/photon/photon_service.dart';
import 'package:tog3ther/util/address_util.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Orte",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    autocorrect: true,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      prefix: SizedBox(
                        width: 10,
                      ),
                      suffix: SizedBox(
                        width: 10,
                      ),
                      hintText: 'Ort eingeben'
                    )
                ),
                suggestionsCallback: (pattern) async {
                  return await getFeatures(pattern);
                },
                itemBuilder: (context, Feature suggestion) {
                  return Listener(
                    child: ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(
                        generateAddress(suggestion),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onPointerDown: (_) async {
                      if (kIsWeb) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        await prefs.setString('last_searched', suggestion.toRawJson());
                        Navigator.of(context).pop(suggestion);
                      }
                    },
                  );
                },
                onSuggestionSelected: (Feature suggestion) async {
                  if (!kIsWeb) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    await prefs.setString('last_searched', suggestion.toRawJson());
                    Navigator.of(context).pop(suggestion);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
          ),
          Divider(
            thickness: 2,
            height: 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Flexible(
            child: ListView(
              children: <Widget>[
                FutureBuilder(
                  builder: (context, feature) {
                    if (feature.connectionState == ConnectionState.none &&
                        feature.hasData == null) {
                      //print('project snapshot data is: ${projectSnap.data}');
                      return Container();
                    }

                    if (feature.data == null) {
                      return Container();
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.grey[200],
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Zuletzt gesucht'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.grey[500]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                              feature.data.properties.name
                          ),
                          onTap: () {
                            Navigator.of(context).pop(feature.data);
                          },
                        ),
                      ],
                    );
                  },
                  future: getLastKnownLocation(),
                ),
                FutureBuilder<Friend>(
                  builder: (context, friend) {
                    if (friend.connectionState == ConnectionState.none &&
                        friend.hasData == null) {
                      //print('project snapshot data is: ${projectSnap.data}');
                      return Container();
                    }

                    if (friend.data == null) {
                      return Container();
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.grey[200],
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Freunde'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.grey[500]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(friend.data.friends[index].color),
                                child: Icon(
                                    IconData(
                                        friend.data.friends[index].iconCodepoint,
                                        fontFamily: 'MaterialIcons'
                                    ),
                                    color: Colors.white
                                ),
                              ),
                              title: Text(
                                  friend.data.friends[index].name
                              ),
                              onTap: () {
                                Navigator.of(context).pop(friend.data.friends[index].feature);
                              },
                            );
                          },
                          itemCount: friend.data.friends.length,
                        ),
                      ],
                    );
                  },
                  future: getFriends(),
                ),
                FutureBuilder<Friend>(
                  builder: (context, friend) {
                    if (friend.connectionState == ConnectionState.none &&
                        friend.hasData == null) {
                      //print('project snapshot data is: ${projectSnap.data}');
                      return Container();
                    }

                    if (friend.data == null) {
                      return Container();
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.grey[200],
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Eigene Orte'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.grey[500]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(friend.data.friends[index].color),
                                child: Icon(
                                    IconData(
                                        friend.data.friends[index].iconCodepoint,
                                        fontFamily: 'MaterialIcons'
                                    ),
                                    color: Colors.white
                                ),
                              ),
                              title: Text(
                                  friend.data.friends[index].name
                              ),
                              onTap: () {
                                Navigator.of(context).pop(friend.data.friends[index].feature);
                              },
                            );
                          },
                          itemCount: friend.data.friends.length,
                        ),
                      ],
                    );
                  },
                  future: getPlaces(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Friend> getFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = prefs.getString('friends');

    if (res == null) {
      return null;
    }

    var friends = Friend.fromJson(jsonDecode(res));

    if (friends.friends.length == 0) {
      return null;
    }

    return friends;
  }

  Future<Friend> getPlaces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = prefs.getString('places');

    if (res == null) {
      return null;
    }

    var friends = Friend.fromJson(jsonDecode(res));

    if (friends.friends.length == 0) {
      return null;
    }

    return friends;
  }

  Future<Feature> getLastKnownLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = prefs.getString('last_searched');

    if (res == null) {
      return null;
    }

    return Feature.fromJson(jsonDecode(res));
  }

  Future<List<Feature>> getFeatures(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('photon_places') == true) {
      return getPhotonFeatures(query);
    } else {
      return getHafasFeatures(query);
    }
  }

  Future<List<Feature>> getPhotonFeatures(String query) async {
    var results = await PhotonService.query(query);

    return results.features;
  }

  Future<List<Feature>> getHafasFeatures(String query) async {
    var results = await HafasService.query(query);

    var convert = HafasService.hafasToGeojson(results);

    return convert.features;
  }
}
