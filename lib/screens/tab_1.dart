import 'package:commitment_tracker/common/utils/route_generator.dart';
import 'package:flutter/material.dart';

class TabOne extends StatefulWidget {
  final String title;
  const TabOne({Key key, this.title}) : super(key: key);

  @override
  _TabOneState createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Hello from ${widget.title ?? ''}"),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, Routes.pageOne,
                  arguments: CommonArgument(title: "This is page one example")),
              child: Text("Go to Page One example"),
            )
          ],
        ),
      ),
    );
  }
}
