import 'package:flutter/material.dart';
import 'package:tog3ther/tools/pref_observable/pref_observable.dart';

class InfoPreference extends StatefulWidget {
  InfoPreference({Key key, this.prefKey, this.title}) : super(key: key);

  final String title;
  final String prefKey;

  @override
  _InfoPreferenceState createState() => _InfoPreferenceState();
}

class _InfoPreferenceState extends State<InfoPreference> {

  PrefObservable prefObservable = PrefObservable(null);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    prefObservable.resolve(widget.prefKey);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: ValueListenableBuilder(
        valueListenable: prefObservable,
        builder: (BuildContext context, dynamic value, child) {
          if (value == null) {
            return Text(
              "Lädt..."
            );
          } else {
            return Text(
              value.toString()
            );
          }
        },
      ),
    );
  }
}
