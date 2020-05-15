import 'package:flutter/material.dart';
import 'package:tog3ther/pages/create_friend_page/create_friend_page.dart';

import '../../theme.dart';

class FriendManually extends StatefulWidget {
  FriendManually({Key key}) : super(key: key);

  @override
  _FriendManuallyState createState() => _FriendManuallyState();
}

class _FriendManuallyState extends State<FriendManually> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: TogetherTheme.cardShape,
      elevation: TogetherTheme.cardElevation,
      shadowColor: Colors.pink.withOpacity(0.6),
      color: Colors.pink,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateFriendPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
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
                      "Manuell",
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
                      "eingeben",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.create,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
