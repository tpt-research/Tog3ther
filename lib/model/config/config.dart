import 'dart:convert';

class Config {
  bool useConfig;
  String confVersion;
  bool isMandant;
  Alert alert;
  bool requireReset;
  List<KeyValuePair> keyValuePairs;

  Config({
    this.useConfig,
    this.confVersion,
    this.isMandant,
    this.alert,
    this.requireReset,
    this.keyValuePairs,
  });

  Config copyWith({
    bool useConfig,
    String confVersion,
    bool isMandant,
    Alert alert,
    bool requireReset,
    List<KeyValuePair> keyValuePairs,
  }) =>
      Config(
        useConfig: useConfig ?? this.useConfig,
        confVersion: confVersion ?? this.confVersion,
        isMandant: isMandant ?? this.isMandant,
        alert: alert ?? this.alert,
        requireReset: requireReset ?? this.requireReset,
        keyValuePairs: keyValuePairs ?? this.keyValuePairs,
      );

  factory Config.fromRawJson(String str) => Config.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    useConfig: json["useConfig"] == null ? null : json["useConfig"],
    confVersion: json["confVersion"] == null ? null : json["confVersion"],
    isMandant: json["isMandant"] == null ? null : json["isMandant"],
    alert: json["alert"] == null ? null : Alert.fromJson(json["alert"]),
    requireReset: json["requireReset"] == null ? null : json["requireReset"],
    keyValuePairs: json["KeyValuePairs"] == null ? null : List<KeyValuePair>.from(json["KeyValuePairs"].map((x) => KeyValuePair.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "useConfig": useConfig == null ? null : useConfig,
    "confVersion": confVersion == null ? null : confVersion,
    "isMandant": isMandant == null ? null : isMandant,
    "alert": alert == null ? null : alert.toJson(),
    "requireReset": requireReset == null ? null : requireReset,
    "KeyValuePairs": keyValuePairs == null ? null : List<dynamic>.from(keyValuePairs.map((x) => x.toJson())),
  };
}

class Alert {
  bool shouldAlert;
  String alertTitle;
  String alertMsg;

  Alert({
    this.shouldAlert,
    this.alertTitle,
    this.alertMsg,
  });

  Alert copyWith({
    bool shouldAlert,
    dynamic alertTitle,
    dynamic alertMsg,
  }) =>
      Alert(
        shouldAlert: shouldAlert ?? this.shouldAlert,
        alertTitle: alertTitle ?? this.alertTitle,
        alertMsg: alertMsg ?? this.alertMsg,
      );

  factory Alert.fromRawJson(String str) => Alert.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    shouldAlert: json["shouldAlert"] == null ? null : json["shouldAlert"],
    alertTitle: json["alertTitle"] == null ? null : json["alertTitle"],
    alertMsg: json["alertMsg"] == null ? null : json["alertMsg"],
  );

  Map<String, dynamic> toJson() => {
    "shouldAlert": shouldAlert == null ? null : shouldAlert,
    "alertTitle": alertTitle == null ? null : alertTitle,
    "alertMsg": alertMsg == null ? null : alertMsg,
  };
}

class KeyValuePair {
  String key;
  dynamic value;
  bool shouldDelete;

  KeyValuePair({
    this.key,
    this.value,
    this.shouldDelete,
  });

  KeyValuePair copyWith({
    String key,
    dynamic value,
    bool shouldDelete,
  }) =>
      KeyValuePair(
        key: key ?? this.key,
        value: value ?? this.value,
        shouldDelete: shouldDelete ?? this.shouldDelete,
      );

  factory KeyValuePair.fromRawJson(String str) => KeyValuePair.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KeyValuePair.fromJson(Map<String, dynamic> json) => KeyValuePair(
    key: json["key"] == null ? null : json["key"],
    value: json["value"],
    shouldDelete: json["shouldDelete"] == null ? null : json["shouldDelete"],
  );

  Map<String, dynamic> toJson() => {
    "key": key == null ? null : key,
    "value": value,
    "shouldDelete": shouldDelete == null ? null : shouldDelete,
  };
}
