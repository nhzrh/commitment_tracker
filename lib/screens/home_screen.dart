import 'package:commitment_tracker/helper/dart/route_generator.dart';
import 'package:commitment_tracker/helper/dart/utils.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:commitment_tracker/services/boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Commitment> commitments = [];

  @override
  void dispose() {
    Hive.box(commitmentBox).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<Commitment>>(
        valueListenable: Boxes.getCommitments().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<Commitment>();
          commitments = data;
          return buildContentList(data);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.detail,
          arguments: CommonArgument(commitment: null),
        ),
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  Widget buildContentList(List<Commitment> data) {
    return SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Commitment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        billPeriod[BillingPeriod.monthly],
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        Utils.getTotal(data),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.keyboard_arrow_up, color: Colors.white),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 50),
              child: Column(
                children: data
                    .map(
                      (e) => Card(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 12.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: e.color.toColor ?? Colors.white,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.detail,
                            arguments: CommonArgument(commitment: e),
                          ),
                          child: ListTile(
                            title: Text(
                              e.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: e.color.toColor.textColorForBackground,
                              ),
                            ),
                            subtitle: e.description.isNotNullOrEmpty
                                ? Text(
                                    e.description,
                                    style: TextStyle(
                                      color: e.color.toColor.textColorForBackground,
                                    ),
                                  )
                                : null,
                            trailing: Text(
                              e.value.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: e.color.toColor.textColorForBackground,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
