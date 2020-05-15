import 'package:flutter/material.dart';
import 'package:tog3ther/util/date_util.dart';

import '../../theme.dart';

class DateSelector extends StatefulWidget {
  DateSelector({Key key}) : super(key: key);

  @override
  DateSelectorState createState() => DateSelectorState();
}

class DateSelectorState extends State<DateSelector> {
  DateTime _curDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: TogetherTheme.cardShape,
      elevation: TogetherTheme.cardElevation,
      shadowColor: Colors.redAccent.withOpacity(0.6),
      color: Colors.redAccent,
      child: InkWell(
        onTap: () {
          _showDatePicker();
        },
        onLongPress: () {
          setState(() {
            _curDate = DateTime.now();
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
                      "Datum",
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
                      generateDateString(_curDate),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDatePicker() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: _curDate,
        firstDate: _curDate.subtract(
            Duration(days: 100)
        ),
        lastDate: _curDate.add(
          Duration(days: 770)
        ),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.redAccent,
              accentColor: Colors.redAccent,
              colorScheme: ColorScheme.light(primary: Colors.redAccent),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child,
          );
        },
    );

    setState(() {
      if (date != null) {
        _curDate = date;
      }
    });
  }

  DateTime exposeDate() {
    return _curDate;
  }
}
