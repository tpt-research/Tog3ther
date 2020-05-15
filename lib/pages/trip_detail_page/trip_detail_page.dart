import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:tog3ther/model/shibi/Trip.dart';
import 'package:tog3ther/theme.dart';
import 'package:tog3ther/util/geometry_util.dart';
import 'package:tog3ther/util/sources_util.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetailPage extends StatefulWidget {
  TripDetailPage({Key key, this.trip}) : super(key: key);

  final Trip trip;

  @override
  _TripDetailPageState createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(48.0),
    topRight: Radius.circular(48.0),
  );

  List<Polyline> polylines = [];
  List<Marker> markers = [];
  List<Marker> importantMarkers = [];

  List<TimelineModel> items = [];

  bool ignoreTap = true;
  MapController _mapController = new MapController();
  PopupController _popupController = PopupController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    items.add(TimelineModel(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              "Start: " + widget.trip.from.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        position: TimelineItemPosition.left,
        iconBackground: Colors.cyan,
        icon: Icon(
          Icons.location_on,
          color: Colors.white,
        )
    ),
    );

    Set<Marker> temp_markers = {};
    bool expanded = true;
    Set<LatLng> polyline_points = {};
    for (var subtrip in widget.trip.routes) {
      polyline_points.add(LatLng(subtrip.from.location.latitude, subtrip.from.location.longitude));

      if (subtrip.stops != null) {
        for (var stop in subtrip.stops) {
          polyline_points.add(LatLng(stop.location.latitude, stop.location.longitude));
          temp_markers.add(Marker(
              width: 30,
              height: 30,
              point: LatLng(stop.location.latitude, stop.location.longitude),
              builder: (context) {
                return CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 15
                  ),
                );
              }
          ));
        }
      }

      polyline_points.add(LatLng(subtrip.to.location.latitude, subtrip.to.location.longitude));

      polylines.add(Polyline(
          points: polyline_points.toList(),
          color: Colors.black
      ));

      importantMarkers.add(Marker(
          point: LatLng(subtrip.from.location.latitude, subtrip.from.location.longitude),
          width: 40,
          height: 40,
          builder: (context) {
            return CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.directions_bus,
                color: Colors.white,
              ),
            );
          }
      ));
      importantMarkers.add(Marker(
          point: LatLng(subtrip.to.location.latitude, subtrip.to.location.longitude),
          width: 40,
          height: 40,
          builder: (context) {
            return CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.directions_bus,
                color: Colors.white,
              ),
            );
          }
      ));

      if (subtrip.from.name != subtrip.to.name) {
        items.add(TimelineModel(
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: TogetherTheme.cardShape,
                  elevation: TogetherTheme.cardElevation - 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ExpansionTile(
                      initiallyExpanded: expanded,
                      onExpansionChanged: (value) {
                        if (value == true) {
                          _mapController.move(
                              LatLng(
                                subtrip.from.location.latitude - 0.021,
                                subtrip.from.location.longitude,
                              ),
                              13.0
                          );
                        }
                      },
                      title: Text(
                        subtrip.from.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                          "Nach: " + subtrip.to.name
                      ),
                      children: <Widget>[
                        if (subtrip.departure.time != null)
                          ListTile(
                            title: Text(
                              "Abfahrt"
                            ),
                            subtitle: Text(
                                subtrip.departure.time.hour.toString().padLeft(2, '0') +
                                    ":" +
                                    subtrip.departure.time.minute.remainder(60).toString().padLeft(2, '0')
                            ),
                            trailing: subtrip.fromTrack != null ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Abschnitt",
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                ),
                                Text(
                                  subtrip.fromTrack,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ) : SizedBox(
                              height: 50,
                              width: 50,
                            ),
                          ),
                        if (subtrip.arrival.time != null)
                          ListTile(
                            title: Text(
                                "Ankunft"
                            ),
                            subtitle: Text(
                                subtrip.arrival.time.hour.toString().padLeft(2, '0') +
                                    ":" +
                                    subtrip.arrival.time.minute.remainder(60).toString().padLeft(2, '0')
                            ),
                            trailing: subtrip.toTrack != null ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Abschnitt",
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                ),
                                Text(
                                  subtrip.toTrack,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ) : SizedBox(
                              height: 50,
                              width: 50,
                            ),
                          ),
                        if (subtrip.vehicle.name != null)
                          ListTile(
                            title: Text(
                                "Linie"
                            ),
                            subtitle: Text(
                                subtrip.vehicle.name
                            ),
                          )
                        else
                          ListTile(
                            title: Text(
                                "Laufweg"
                            ),
                            subtitle: Text(
                                calculateDistance(
                                    LatLng(
                                      subtrip.from.location.latitude,
                                      subtrip.from.location.longitude,
                                    ),
                                    LatLng(
                                      subtrip.to.location.latitude,
                                      subtrip.to.location.longitude
                                    )
                                ).toString() + "km"
                            ),
                            trailing: Icon(
                              Icons.directions_walk
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            position: TimelineItemPosition.left,
            iconBackground: Colors.black,
            icon: Icon(
              Icons.directions_bus,
              color: Colors.white,
            )
          ),
        );
      }

      expanded = false;
    }

    items.add(TimelineModel(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              "Ziel erreicht: " + widget.trip.to.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        position: TimelineItemPosition.left,
        iconBackground: Colors.green,
        icon: Icon(
          Icons.check,
          color: Colors.white,
        )
    ),
    );

    markers = temp_markers.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 5,
        title: Text(
          "Details",
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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        getLogoURL(widget.trip.routes.first.source)
                    )
                )
              ),
            ),
          )
        ],
      ),
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: radius,
        minHeight: MediaQuery.of(context).size.height * 0.40,
        maxHeight: MediaQuery.of(context).size.height * 0.60,
        onPanelOpened: () {
          setState(() {
            ignoreTap = false;
          });
        },
        onPanelClosed: () {
          setState(() {
            ignoreTap = true;
          });
        },
        panel: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            ),
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24.0)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Strecke",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.47,
                width: MediaQuery.of(context).size.width * 0.90,
                child: IgnorePointer(
                  ignoring: ignoreTap,
                  child: Timeline(
                      children: items,
                      position: TimelinePosition.Left
                  ),
                )
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: FlutterMap(
              mapController: _mapController,
              options: new MapOptions(
                  center: LatLng(widget.trip.from.location.latitude - 0.025, widget.trip.from.location.longitude),
                  zoom: 13.0,
                  maxZoom: 17.0,
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                  onTap: (_) => _popupController
                      .hidePopup()
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate: "http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']
                ),
                PolylineLayerOptions(
                  polylines: polylines,
                ),
                MarkerLayerOptions(
                  markers: importantMarkers,
                ),
                MarkerClusterLayerOptions(
                  maxClusterRadius: 120,
                  size: Size(40, 40),
                  anchor: AnchorPos.align(AnchorAlign.center),
                  fitBoundsOptions: FitBoundsOptions(
                    padding: EdgeInsets.all(50),
                  ),
                  markers: markers,
                  polygonOptions: PolygonOptions(
                      borderColor: Colors.transparent,
                      color: Colors.transparent,
                      borderStrokeWidth: 3),
                  popupOptions: PopupOptions(
                      popupSnap: PopupSnap.top,
                      popupController: _popupController,
                      popupBuilder: (_, marker) => Container(
                        height: 80,
                        width: 200,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () => debugPrint("Popup tap!"),
                          child: Card(
                            shape: TogetherTheme.cardShape,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  checkForTrip(marker),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                  builder: (context, markers) {
                    return FloatingActionButton(
                      backgroundColor: Colors.black,
                      child: Text(
                        markers.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      onPressed: null,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: widget.trip.routes.first.url != null ? AnimatedOpacity(
        opacity: ignoreTap == true ? 0.0 : 1.0,
        duration: Duration(milliseconds: 200),
        child: IgnorePointer(
          ignoring: ignoreTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            child: RaisedButton(
              shape: TogetherTheme.cardShape,
              onPressed: () async {
                if (await canLaunch(widget.trip.routes.first.url)) {
                  await launch(widget.trip.routes.first.url);
                }
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
                        Icons.info,
                        color: Colors.white,
                      ),
                      Text(
                        "Infos".toUpperCase(),
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
      ) : Container(),
    );
  }

  String checkForTrip(Marker marker) {
    for (var routes in widget.trip.routes) {
      for (var places in routes.stops) {
        if (LatLng(places.location.latitude, places.location.longitude) == marker.point) {
          return places.name;
        }
      }
    }

    return "";
  }
}
