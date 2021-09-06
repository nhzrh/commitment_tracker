import 'package:commitment_tracker/common/utils/constant.dart';
import 'package:commitment_tracker/common/utils/custom_colors.dart';
import 'package:commitment_tracker/common/utils/route_generator.dart';
import 'package:commitment_tracker/common/utils/utils.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:commitment_tracker/services/boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CommitmentScreen extends StatefulWidget {
  const CommitmentScreen({Key key}) : super(key: key);

  @override
  _CommitmentScreenState createState() => _CommitmentScreenState();
}

class _CommitmentScreenState extends State<CommitmentScreen> {
  List<Commitment> commitments = [];

  @override
  void dispose() {
    Hive.box(Constants.commitmentBox).close();
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    billPeriod[BillingPeriod.monthly],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Commitment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Utils.getTotal(data) != 0.0
                        ? Utils.getTotalAfter(data) != 0.0
                            ? Utils.formatPrice('RM', Utils.getTotalAfter(data)) + ' left'
                            : 'Completed'
                        : '',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    Utils.formatPrice('RM', Utils.getTotal(data)),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
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
                children: data.map(
                  (e) {
                    if (!e.isArchive) {
                      return buildCardItem(e);
                    }
                    return Container();
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void deleteCommitment(Commitment e) {
    e.delete();
    _showSnackBar(context, '${e.name} has been deleted');
  }

  void archiveCommitment(Commitment e) {
    e.isArchive = true;
    e.save();
    _showSnackBar(context, '${e.name} has been archive');
  }

  Widget buildCardItem(Commitment e) {
    return Slidable(
      key: Key(UniqueKey().toString()),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          if (actionType == SlideActionType.primary) {
            archiveCommitment(e);
          } else {
            deleteCommitment(e);
          }
        },
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.detail,
          arguments: CommonArgument(commitment: e),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.green,
                      shape: CircleBorder(),
                      value: e.isCompleted,
                      onChanged: (b) {
                        e.isCompleted = b;
                        e.save();
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name,
                            style: TextStyle(
                              color:
                                  e.isCompleted ? CustomColors.TextGrey : CustomColors.TextHeader,
                              decoration: e.isCompleted ? TextDecoration.lineThrough : null,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          Visibility(
                            visible: e.description.isNotNullOrEmpty,
                            child: Text(
                              e.description,
                              style: TextStyle(
                                color: e.isCompleted
                                    ? CustomColors.TextGrey
                                    : CustomColors.TextSubHeader,
                                decoration: e.isCompleted ? TextDecoration.lineThrough : null,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Utils.formatPrice('RM', e.value),
                  style: TextStyle(
                    color: e.isCompleted ? CustomColors.TextGrey : CustomColors.TextHeader,
                    decoration: e.isCompleted ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0.045, 0.048],
              colors: [
                e.color.toColor ?? Colors.white,
                e.isCompleted ? CustomColors.BlackBackground : Colors.white
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.BlackBorder,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
        ),
      ),
      actions: [
        SlideAction(
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.TrashRedBackground),
                  child: Icon(Icons.archive),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Archive',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          onTap: () => archiveCommitment(e),
        ),
      ],
      secondaryActions: [
        SlideAction(
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.TrashRedBackground),
                  child: Icon(Icons.delete),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          onTap: () => deleteCommitment(e),
        ),
      ],
    );
  }
}
