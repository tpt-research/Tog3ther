import 'package:flutter/material.dart';
import 'package:tog3ther/components/info_preference/info_preference.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key key}) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Informationen",
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
      body: ListView(
        children: <Widget>[
          InfoPreference(
            prefKey: 'app_name',
            title: 'App Name',
          ),
          InfoPreference(
            prefKey: 'version',
            title: 'App Version',
          ),
          InfoPreference(
            prefKey: 'package_name',
            title: 'Package Name',
          ),
          InfoPreference(
            prefKey: 'build_number',
            title: 'Build',
          ),
          InfoPreference(
            prefKey: 'ver_conf_key',
            title: 'Config-Version',
          ),
          ListTile(
            title: Text(
              "Shibi Version",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              "1.0"
            ),
          ),
          ListTile(
            title: Text(
              "Shuvi-Metasuche Version",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
                "0.0.1"
            ),
          )
        ],
      ),
    );
  }
}
