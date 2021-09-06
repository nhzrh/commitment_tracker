import 'package:commitment_tracker/common/constant.dart';
import 'package:commitment_tracker/models/month_model.dart';
import 'package:flutter/material.dart';

class ExpansionScreen extends StatefulWidget {
  const ExpansionScreen({Key key}) : super(key: key);

  @override
  _ExpansionScreenState createState() => _ExpansionScreenState();
}

class _ExpansionScreenState extends State<ExpansionScreen> {
  List<MonthModel> monthModel;

  @override
  void initState() {
    monthModel = Constants.getMonthModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: monthModel.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildPlayerModelList(monthModel[index]);
        },
      ),
    );
  }

  Widget _buildPlayerModelList(MonthModel items) {
    return Card(
      child: ExpansionTile(
        key: UniqueKey(),
        title: Text(
          items.name,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              items.description,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
