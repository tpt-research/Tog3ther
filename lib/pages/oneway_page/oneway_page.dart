import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:tog3ther/animations/show_up/show_up.dart';
import 'package:tog3ther/components/date_selector/date_selector.dart';
import 'package:tog3ther/components/menu_injector/menu_injector.dart';
import 'package:tog3ther/components/time_selector/time_selector.dart';
import 'package:tog3ther/model/geojson/geojson.dart';
import 'package:tog3ther/model/searchcluster/SearchCluster.dart';
import 'package:tog3ther/pages/search_page/search_page.dart';
import 'package:tog3ther/pages/show_trips_page/show_trips_page.dart';
import 'package:tog3ther/services/hafas/hafas_service.dart';
import 'package:tog3ther/services/shuvi/shuvi_request_provider.dart';
import 'package:tog3ther/util/date_util.dart';
import 'package:tog3ther/util/sources_util.dart';

import '../../theme.dart';

class OnewayPage extends StatefulWidget {
  OnewayPage({Key key, this.predefined}) : super(key: key);

  final Feature predefined;

  @override
  _OnewayPageState createState() => _OnewayPageState();
}

class _OnewayPageState extends State<OnewayPage> {

  Feature globalGeoFeature;

  GlobalKey<MenuInjectorState> _menuKey = GlobalKey<MenuInjectorState>();

  GlobalKey<DateSelectorState> _dateKey = GlobalKey<DateSelectorState>();
  GlobalKey<TimeSelectorState> _timeKey = GlobalKey<TimeSelectorState>();

  bool visible = false;

  @override
  void initState() {
    super.initState();

    if (widget.predefined != null) {
      globalGeoFeature = widget.predefined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuInjector(
      key: _menuKey,
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Einfache Suche",
            style: TextStyle(
              color: Colors.black
            ),
          ),
          leading: IconButton(
            onPressed: () {
              _menuKey.currentState.toggle();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ShowUp(
                    delay: 100,
                    child: Card(
                      shape: TogetherTheme.cardShape,
                      elevation: TogetherTheme.cardElevation,
                      shadowColor: Colors.grey.withOpacity(0.6),
                      child: InkWell(
                        onTap: () async {
                          var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));

                          if (result != null) {
                            setState(() {
                              globalGeoFeature = result;
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
                                    "Wohin geht's heute ?",
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
                                    globalGeoFeature == null ? "Bitte hier eingeben" : globalGeoFeature.properties.name,
                                    style: TextStyle(
                                        fontWeight: globalGeoFeature == null ? FontWeight.normal : FontWeight.bold,
                                        color: globalGeoFeature == null ? Colors.grey : Colors.black,
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
                    delay: 200,
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
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.0),
                                child: FlutterMap(
                                  options: new MapOptions(
                                      center: globalGeoFeature == null ? LatLng(51.5, -0.09) : LatLng(globalGeoFeature.geometry.coordinates[1], globalGeoFeature.geometry.coordinates[0]),
                                      zoom: 13.0,
                                      maxZoom: 17.0
                                  ),
                                  layers: [
                                    new TileLayerOptions(
                                        urlTemplate: "http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                                        subdomains: ['a', 'b', 'c']
                                    ),
                                    if (globalGeoFeature != null)
                                      new MarkerLayerOptions(
                                          markers: <Marker>[
                                            Marker(
                                                point: LatLng(globalGeoFeature.geometry.coordinates[1], globalGeoFeature.geometry.coordinates[0]),
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
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  ShowUp(
                    delay: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        TimeSelector(
                          key: _timeKey,
                        ),
                        DateSelector(
                          key: _dateKey,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  ShowUp(
                    delay: 400,
                    child: RaisedButton(
                        shape: TogetherTheme.cardShape,
                        color: Colors.white,
                        onPressed: () async {
                          setState(() {
                            visible = true;
                          });
                          var location = await getLocation();

                          var search = await createSearch(location.features.first);

                          if (search == null) {
                            setState(() {
                              visible = false;
                            });
                            return;
                          }

                          setState(() {
                            visible = false;
                          });

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowTripsPage(search: search)));
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                size: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                              ),
                              Text(
                                "Suchen",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Visibility(
                visible: visible,
                child: IgnorePointer(
                  ignoring: visible,
                  child: AnimatedOpacity(
                      child: Container(
                        color: Theme.of(context).canvasColor.withOpacity(0.6),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3),
                              ),
                              Text(
                                  "Standort wird gesucht..."
                              )
                            ],
                          ),
                        ),
                      ),
                      opacity: visible == true ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500)
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Future<SearchCluster> createSearch(Feature location) async {
    if (globalGeoFeature == null || globalGeoFeature == null) {
      showToast('Eingaben unvollständig');
      return null;
    }

    return ShuviRequestProvider.createCluster(
        fromLatitude: location.geometry.coordinates[1],
        fromLongitude: location.geometry.coordinates[0],
        toLatitude: globalGeoFeature.geometry.coordinates[1],
        toLongitude: globalGeoFeature.geometry.coordinates[0],
        fromName: globalGeoFeature.properties.name,
        toName: globalGeoFeature.properties.name,
        date: generateTimestamp(
            _dateKey.currentState.exposeDate(),
            _timeKey.currentState.exposeTime(),
            context
        ),
        sources: await generateSources()
    );
  }

  Future<GeoJSON> getLocation() async {
    await Geolocator().checkGeolocationPermissionStatus();

    var location = await Geolocator().getCurrentPosition();

    return HafasService.hafasToGeojson(
        await HafasService.reverse(location.latitude, location.longitude)
    );
  }
}
