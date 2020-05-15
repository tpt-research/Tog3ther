import 'package:flutter/material.dart';
import 'package:tog3ther/tools/pref_observable/pref_observable.dart';

class CheckboxPreference extends StatefulWidget {
  CheckboxPreference({Key key, this.title, this.prefKey, this.leadingURL}) : super(key: key);

  final String title;
  final String leadingURL;
  final String prefKey;

  @override
  _CheckboxPreferenceState createState() => _CheckboxPreferenceState();
}

class _CheckboxPreferenceState extends State<CheckboxPreference> {

  PrefObservable prefObservable = PrefObservable(null);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    prefObservable.resolve(widget.prefKey);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        prefObservable.switchBool(widget.prefKey);
      },
      leading: SizedBox(
        width: 40,
        child: Center(child: Image.network(widget.leadingURL)),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      trailing: ValueListenableBuilder(
        valueListenable: prefObservable,
        builder: (BuildContext context, dynamic value, child) {
          return Checkbox(
            value: value != null ? value : true,
            onChanged: (bool value) {
              prefObservable.set(widget.prefKey, value);
            },
          );
        },
      ),
    );
  }
}
