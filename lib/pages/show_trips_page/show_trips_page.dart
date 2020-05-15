import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:tog3ther/animations/show_up/show_up.dart';
import 'package:tog3ther/components/menu_injector/menu_injector.dart';
import 'package:tog3ther/model/searchcluster/SearchCluster.dart';
import 'package:tog3ther/model/shuvi/Shuvi.dart';
import 'package:tog3ther/pages/trip_detail_page/trip_detail_page.dart';
import 'package:tog3ther/theme.dart';
import 'package:tog3ther/tools/search_observable/search_observable.dart';
import 'package:tog3ther/util/sources_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowTripsPage extends StatefulWidget {
  ShowTripsPage({Key key, this.search}) : super(key: key);

  final SearchCluster search;

  @override
  _ShowTripsPageState createState() => _ShowTripsPageState();
}

class _ShowTripsPageState extends State<ShowTripsPage> {

  SearchObservable searchObservable;

  @override
  void initState() {
    super.initState();

    searchObservable = SearchObservable(null, widget.search);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    searchObservable.search();
  }

  @override
  Widget build(BuildContext context) {
    return MenuInjector(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Fahrten",
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
        body: ValueListenableBuilder(
          valueListenable: searchObservable,
          builder: (BuildContext context, Shuvi value, child) {
            if (value == null) {
              return Center(
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
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Text(
                      "Shibi sucht...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              );
            } else if (value.result == null) {
              return Center(
                child: Text(
                  "Es konnten keine Fahrten gefunden werden."
                ),
              );
            } else {
              List<Widget> tripElements = [];
              tripElements.add(Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: OutlineButton(
                            shape: TogetherTheme.cardShape,
                            onPressed: () {
                              searchObservable.now();
                            },
                            child: Center(
                              child: Text(
                                  'Jetzt'
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: OutlineButton(
                            shape: TogetherTheme.cardShape,
                            onPressed: () {
                              searchObservable.prev(value);
                            },
                            child: Center(
                              child: Text(
                                  'Vorher'
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ));

              for (var trip in value.result.trips) {
                var depDiff;
                if (trip.arrival.time != null) {
                  depDiff = trip.arrival.time.difference(trip.departure.time);
                }

                tripElements.add(Container(
                  padding: EdgeInsets.all(12.0),
                  child: Card(
                    shape: TogetherTheme.cardShape,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TripDetailPage(trip: trip)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (trip.departure.time != null && (trip.departure.time != trip.arrival.time))
                            Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    trip.departure.time.hour.toString().padLeft(2, '0') + ":" +
                                        trip.departure.time.minute.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  Text(
                                    trip.arrival.time.hour.toString().padLeft(2, '0') + ":" +
                                        trip.arrival.time.minute.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  Text(
                                    depDiff.inHours.toString() + ":" +
                                        depDiff.inMinutes.remainder(60).toString().padLeft(2, '0'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  Text(
                                    "Umst. " + (trip.routes.length - 1).toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (trip.departure.time == null)
                            Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Uhrzeit egal",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          if ((trip.departure.time == trip.arrival.time) && trip.departure.time != null)
                            Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Start ab: " + trip.departure.time.hour.toString().padLeft(2, '0') + ":" +
                                      trip.departure.time.minute.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                          Divider(
                            thickness: 1,
                            height: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    trip.from.name
                                ),
                                Text(
                                    trip.to.name
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    trip.routes.first.source
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Image.network(
                                      getLogoURL(trip.routes.first.source)
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
              }

              tripElements.add(Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: OutlineButton(
                      shape: TogetherTheme.cardShape,
                      onPressed: () {
                        searchObservable.next(value);
                      },
                      child: Center(
                        child: Text(
                          'Später'
                        ),
                      ),
                    ),
                  )
                ],
              ));

              tripElements.add(MaterialButton(
                onPressed: () async {
                  var url = "https://github.com/ReThinkMobility/Shibi";
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: Center(
                  child: Text(
                    "Powered by Shibi",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey
                    ),
                  ),
                ),
              ));

              tripElements.add(Padding(
                padding: EdgeInsets.only(top: 80),
              ));

              return ShowUp(
                child: ListView(
                  children: tripElements,
                ),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          child: RaisedButton(
            shape: TogetherTheme.cardShape,
            onPressed: () async {
              searchObservable.retry();
            },
            color: Colors.cyan,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      MaterialCommunityIcons.reload,
                      color: Colors.white,
                    ),
                    Text(
                      "Erneut suchen".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
