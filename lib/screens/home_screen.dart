import 'package:commitment_tracker/helper/dart/route_generator.dart';
import 'package:commitment_tracker/helper/dart/utils.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Commitment> commitments = [];

  void addCommitment(Commitment data) {
    setState(() {
      commitments.add(data);
    });
  }

  TextStyle _textStyle(Color color, {bool isBold}) => TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Utils.textColorForBackground(color ?? Colors.white),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commitment'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(billPeriod[BillingPeriod.monthly]),
                    Text(
                      commitments != null && commitments.isNotEmpty
                          ? commitments
                              .map((e) => e.value)
                              .reduce((value, element) => value + element)
                              .toString()
                          : 0.0.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard_arrow_up),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: commitments
              .map(
                (e) => Card(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 12.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: e.color ?? Colors.white,
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.detail,
                      arguments: CommonArgument(
                        commitment: e,
                        add: addCommitment,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        e.name,
                        style: _textStyle(e.color),
                      ),
                      trailing: Text(
                        e.value.toString(),
                        style: _textStyle(e.color, isBold: true),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.detail,
          arguments: CommonArgument(
            commitment: null,
            add: addCommitment,
          ),
        ),
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
