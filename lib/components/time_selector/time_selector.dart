import 'package:flutter/material.dart';
import 'package:tog3ther/util/date_util.dart';

import '../../theme.dart';

class TimeSelector extends StatefulWidget {
  TimeSelector({Key key}) : super(key: key);

  @override
  TimeSelectorState createState() => TimeSelectorState();
}

class TimeSelectorState extends State<TimeSelector> {
  TimeOfDay _curTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: TogetherTheme.cardShape,
      elevation: TogetherTheme.cardElevation,
      shadowColor: Theme.of(context).primaryColor.withOpacity(0.6),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          _showTimePicker();
        },
        onLongPress: () {
          setState(() {
            _curTime = TimeOfDay.now();
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.42,
          height: 100,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Uhrzeit",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.white
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                    ),
                    Text(
                      generateTimeString(_curTime, context),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTimePicker() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _curTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    setState(() {
      if (picked != null) {
        _curTime = picked;
      }
    });
  }

  TimeOfDay exposeTime() {
    return _curTime;
  }
}
