import 'package:commitment_tracker/base/base_stateful.dart';
import 'package:commitment_tracker/common/constant.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  final String title;
  const PageOne({Key key, this.title}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends BaseStateful<PageOne> {
  @override
  List<Widget> getAction() => null;

  @override
  String getAppTitle() => widget.title ?? "Page One Example";

  @override
  Widget getBottomNavigation() => null;

  @override
  Widget getChildView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: Constants.getMonthModel()
              .map((item) => ListTile(
                    title: Text(
                      item.name,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget getDrawer() => null;

  @override
  Widget getFloatingActionButton() => null;
}
