import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

Future<List<String>> generateSources() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> sources = [];

  if (prefs.getBool('db_enabled') != false) {
    sources.add('deutschebahn');
  }
  if (prefs.getBool('flx_enabled') != false) {
    sources.add('flixbus');
  }
  if (prefs.getBool('bvg_enabled') != false) {
    sources.add('bvg');
  }
  if (prefs.getBool('oebb_enabled') != false) {
    sources.add('oebb');
  }
  if (prefs.getBool('rmv_enabled') != false) {
    sources.add('rmv');
  }
  if (prefs.getBool('avv_enabled') != false) {
    sources.add('avv');
  }
  if (prefs.getBool('insa_enabled') != false) {
    sources.add('insa');
  }
  if (prefs.getBool('vbn_enabled') != false) {
    sources.add('vbn');
  }
  if (prefs.getBool('vor_enabled') != false) {
    sources.add('anachb');
  }
  if (prefs.getBool('sncb_enabled') != false) {
    sources.add('sncb');
  }
  if (prefs.getBool('mifaz_enabled') != false) {
    sources.add('mifaz');
  }

  return sources;
}

String getLogoURL(String source) {
  var url = "";

  switch(source) {
    case "Deutsche Bahn (DB Navigator)":
      url = TogetherConstants.DB_IMG_URL;
      break;
    case "FlixBus":
      url = TogetherConstants.FLIXBUS_IMG_URL;
      break;
    case "Berliner Verkehrsgesellschaft":
      url = TogetherConstants.BVG_IMG_URL;
      break;
    case "Österreichische Bundesbahn":
      url = TogetherConstants.OEBB_IMG_URL;
      break;
    case "Rhein-Main Verkehrsbund":
      url = TogetherConstants.RMV_IMG_URL;
      break;
    case "Aachener Verkehrsgesellschaft":
      url = TogetherConstants.AVV_IMG_URL;
      break;
    case "INSA":
      url = TogetherConstants.INSA_IMG_URL;
      break;
    case "Verkehrsverbund Bremen/Niedersachsen (VBN)":
      url = TogetherConstants.INSA_IMG_URL;
      break;
    case "Société nationale des chemins de fer belges":
      url = TogetherConstants.SNCB_IMG_URL;
      break;
    case "Verkehrsverbund Ost-Region (VOR)":
      url = TogetherConstants.VOR_IMG_URL;
      break;
  }

  if (source.indexOf("MiFaz") != -1) {
    url = TogetherConstants.MIFAZ_IMG_URL;
  }

  return url;
}
