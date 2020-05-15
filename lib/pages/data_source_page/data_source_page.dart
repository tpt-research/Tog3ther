import 'package:flutter/material.dart';
import 'package:tog3ther/animations/show_up/show_up.dart';
import 'package:tog3ther/components/checkbox_preference/checkbox_preference.dart';
import 'package:tog3ther/constants.dart';

class DataSourcePage extends StatefulWidget {
  DataSourcePage({Key key}) : super(key: key);

  @override
  _DataSourcePageState createState() => _DataSourcePageState();
}

class _DataSourcePageState extends State<DataSourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Datenquellen",
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
            CheckboxPreference(
              leadingURL: TogetherConstants.DB_IMG_URL,
              title: "Deutsche Bahn",
              prefKey: "db_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.FLIXBUS_IMG_URL,
              title: "FlixBus",
              prefKey: "flx_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.BVG_IMG_URL,
              title: "Berliner Verkehrsgesellschaften",
              prefKey: "bvg_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.OEBB_IMG_URL,
              title: "Österreichische Bundesbahn",
              prefKey: "oebb_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.RMV_IMG_URL,
              title: "Rhein-Main Verkehrsbund",
              prefKey: "rmv_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.AVV_IMG_URL,
              title: "Aachener Verkehrsverbund",
              prefKey: "avv_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.INSA_IMG_URL,
              title: "INSA",
              prefKey: "insa_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.VBN_IMG_URL,
              title: "Verkehrsverbund Bremen-Niedersachsen",
              prefKey: "vbn_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.VOR_IMG_URL,
              title: "Verkehrsverbund Ost-Region (VOR & ITS)",
              prefKey: "sncb_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.SNCB_IMG_URL,
              title: "SNCB",
              prefKey: "sncb_enabled",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            CheckboxPreference(
              leadingURL: TogetherConstants.MIFAZ_IMG_URL,
              title: "Mitfahrzentrale (MiFaz)",
              prefKey: "mifaz_enabled",
            ),
          ],
        ),
      ),
    );
  }
}
