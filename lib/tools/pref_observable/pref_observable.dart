import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefObservable extends ValueNotifier<dynamic> {
  PrefObservable(value) : super(value);

  Future<void> resolve(String key) async {
    var prefs = await SharedPreferences.getInstance();

    this.value = prefs.get(key);
    notifyListeners();
  }

  Future<void> set(String key, dynamic value) async {
    var prefs = await SharedPreferences.getInstance();

    if (value is String) {
      prefs.setString(key, value);
    }
    if (value is int) {
      prefs.setInt(key, value);
    }
    if (value is double) {
      prefs.setDouble(key, value);
    }
    if (value is bool) {
      prefs.setBool(key, value);
    }
    if (value is List<String>) {
      prefs.setStringList(key, value);
    }

    this.value = value;

    notifyListeners();
  }

  Future<void> switchBool(String key) async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(key) == true) {
      value = false;
      prefs.setBool(key, value);
    } else {
      value = true;
      prefs.setBool(key, value);
    }

    notifyListeners();
  }

  Future<void> remove(String key) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.remove(key);
    this.value = null;

    notifyListeners();
  }
}
