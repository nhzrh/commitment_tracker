import 'package:commitment_tracker/common/constant.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Commitment> getCommitments() => Hive.box<Commitment>(Constants.commitmentBox);
}
