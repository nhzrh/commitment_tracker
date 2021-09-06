import 'dart:async';

import 'package:flutter/material.dart';

abstract class BaseStateful<T extends StatefulWidget> extends State<T> {
  String getAppTitle();
  List<Widget> getAction();
  Widget getChildView();
  Widget getBottomNavigation();
  Widget getDrawer();
  Widget getFloatingActionButton();

  Future<bool> _onWillPop() async {
    return backTap(context) ?? false;
  }

  bool backTap(BuildContext context) {
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(getAppTitle() ?? ''),
          actions: getAction(),
        ),
        drawer: getDrawer(),
        body: getChildView(),
        backgroundColor: Colors.grey[100],
        bottomNavigationBar: getBottomNavigation(),
        floatingActionButton: getFloatingActionButton(),
      ),
    );
  }
}
