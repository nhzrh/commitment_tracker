import 'package:commitment_tracker/helper/dart/utils.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Commitment> getCommitments() => Hive.box<Commitment>(commitmentBox);
}
