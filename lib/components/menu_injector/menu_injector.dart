import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:tog3ther/pages/menu_page/menu_page.dart';

class MenuInjector extends StatefulWidget {
  const MenuInjector({Key key, this.scaffold}) : super(key: key);

  final Scaffold scaffold;

  @override
  MenuInjectorState createState() => MenuInjectorState();
}

class MenuInjectorState extends State<MenuInjector> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      scaffold: widget.scaffold,
      offset: IDOffset.only(
          left: 0.3
      ),
      backgroundColor: Theme.of(context).canvasColor,
      scale: IDOffset.horizontal(0.8),
      proportionalChildArea : true,
      borderRadius: 50,
      leftAnimationType: InnerDrawerAnimation.quadratic,
      leftChild: MenuPage(),
    );
  }

  void toggle() {
    _innerDrawerKey.currentState.toggle(
        direction: InnerDrawerDirection.start
    );
  }
}
