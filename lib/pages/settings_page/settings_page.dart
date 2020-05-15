import 'package:flutter/material.dart';
import 'package:tog3ther/animations/show_up/show_up.dart';
import 'package:tog3ther/pages/data_source_page/data_source_page.dart';
import 'package:tog3ther/pages/information_page/information_page.dart';
import 'package:tog3ther/tools/pref_observable/pref_observable.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PrefObservable prefObservableSearch = PrefObservable(null);
  PrefObservable prefObservablePhoton = PrefObservable(null);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    prefObservableSearch.resolve('detailed_search');
    prefObservablePhoton.resolve('photon_places');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Einstellungen",
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
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            ListTile(
              onTap: () {
                prefObservableSearch.switchBool('detailed_search');
              },
              leading: Icon(
                Icons.search,
                color: Colors.deepOrangeAccent,
              ),
              title: Text(
                "Fahrt-Suchgenauigkeit erhöhen",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                "Erhöht die Genauigkeit der Fahrtensuche, ist aber langsamer."
              ),
              trailing: ValueListenableBuilder(
                valueListenable: prefObservableSearch,
                builder: (BuildContext context, dynamic value, child) {
                  return Checkbox(
                    value: value != null ? value : false,
                    onChanged: (bool value) {
                      prefObservableSearch.set('detailed_search', value);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            ListTile(
              onTap: () {
                prefObservablePhoton.switchBool('photon_places');
              },
              leading: Icon(
                Icons.map,
                color: Colors.green,
              ),
              title: Text(
                "Photon Ortssuche",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                  "Benutzt offene und schnellere Daten für die Ortssuche, ist aber ungenauer."
              ),
              trailing: ValueListenableBuilder(
                valueListenable: prefObservablePhoton,
                builder: (BuildContext context, dynamic value, child) {
                  return Checkbox(
                    value: value != null ? value : false,
                    onChanged: (bool value) {
                      prefObservablePhoton.set('photon_places', value);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataSourcePage()));
              },
              leading: Container(
                alignment: Alignment.centerLeft,
                width: 10,
                child: Icon(
                  Icons.data_usage,
                  color: Colors.pink,
                ),
              ),
              title: Text(
                "Datenquellen",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                  "Datenquellen für die Suche"
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => InformationPage()));
              },
              leading: Container(
                alignment: Alignment.centerLeft,
                width: 10,
                child: Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
              ),
              title: Text(
                "Informationen",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                "Informationen zur App"
              ),
            )
          ],
        ),
      ),
    );
  }
}
