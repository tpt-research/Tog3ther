import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tog3ther/animations/show_up/show_up.dart';
import 'package:tog3ther/components/date_selector/date_selector.dart';
import 'package:tog3ther/components/menu_injector/menu_injector.dart';
import 'package:tog3ther/components/time_selector/time_selector.dart';
import 'package:tog3ther/model/geojson/geojson.dart';
import 'package:tog3ther/model/searchcluster/SearchCluster.dart';
import 'package:tog3ther/pages/search_page/search_page.dart';
import 'package:tog3ther/pages/show_trips_page/show_trips_page.dart';
import 'package:tog3ther/services/shuvi/shuvi_request_provider.dart';
import 'package:tog3ther/util/date_util.dart';
import 'package:tog3ther/util/sources_util.dart';

import '../../theme.dart';

class TwowayPage extends StatefulWidget {
  TwowayPage({Key key}) : super(key: key);

  @override
  _TwowayPageState createState() => _TwowayPageState();
}

class _TwowayPageState extends State<TwowayPage> {

  Feature globalGeoFeatureFrom;
  Feature globalGeoFeatureTo;

  GlobalKey<MenuInjectorState> _menuKey = GlobalKey<MenuInjectorState>();

  GlobalKey<DateSelectorState> _dateKey = GlobalKey<DateSelectorState>();
  GlobalKey<TimeSelectorState> _timeKey = GlobalKey<TimeSelectorState>();

  @override
  Widget build(BuildContext context) {
    return MenuInjector(
      key: _menuKey,
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Detailierte Suche",
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
        body: Container(
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
                          globalGeoFeatureFrom = result;
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
                                "Start",
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
                                globalGeoFeatureFrom == null ? "Bitte hier eingeben" : globalGeoFeatureFrom.properties.name,
                                style: TextStyle(
                                    fontWeight: globalGeoFeatureFrom == null ? FontWeight.normal : FontWeight.bold,
                                    color: globalGeoFeatureFrom == null ? Colors.grey : Colors.black,
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
                child: Card(
                  shape: TogetherTheme.cardShape,
                  elevation: TogetherTheme.cardElevation,
                  shadowColor: Colors.grey.withOpacity(0.6),
                  child: InkWell(
                    onTap: () async {
                      var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));

                      if (result != null) {
                        setState(() {
                          globalGeoFeatureTo = result;
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
                                "Ziel",
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
                                globalGeoFeatureTo == null ? "Bitte hier eingeben" : globalGeoFeatureTo.properties.name,
                                style: TextStyle(
                                    fontWeight: globalGeoFeatureTo == null ? FontWeight.normal : FontWeight.bold,
                                    color: globalGeoFeatureTo == null ? Colors.grey : Colors.black,
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
                      var search = await createSearch();

                      if (search == null) {
                        return;
                      }

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
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Future<SearchCluster> createSearch() async {
    if (globalGeoFeatureTo == null || globalGeoFeatureTo == null) {
      showToast('Eingaben unvollständig');
      return null;
    }

    return ShuviRequestProvider.createCluster(
      fromLatitude: globalGeoFeatureFrom.geometry.coordinates[1],
      fromLongitude: globalGeoFeatureFrom.geometry.coordinates[0],
      toLatitude: globalGeoFeatureTo.geometry.coordinates[1],
      toLongitude: globalGeoFeatureTo.geometry.coordinates[0],
      fromName: globalGeoFeatureFrom.properties.name,
      toName: globalGeoFeatureTo.properties.name,
      date: generateTimestamp(
          _dateKey.currentState.exposeDate(),
          _timeKey.currentState.exposeTime(),
          context
      ),
      sources: await generateSources()
    );
  }
}
