import 'package:hive/hive.dart';

part 'commitments.g.dart';

@HiveType(typeId: 0)
class Commitment extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  double value = 0.0;
  @HiveField(3)
  String label;
  @HiveField(4)
  String billingPeriod;
  @HiveField(5)
  String note;
  @HiveField(6)
  int color;
  @HiveField(7)
  bool isCompleted = false;
  @HiveField(8)
  bool isRecurring = false;
  @HiveField(9)
  bool isSync = false;
  @HiveField(10)
  bool isArchive = false;
  @HiveField(11)
  DateTime createdAt;
  @HiveField(12)
  String notes;

  Commitment({
    this.name,
    this.description,
    this.value,
    this.label,
    this.billingPeriod = 'Monthly',
    this.note,
    this.color,
    this.isCompleted = false,
    this.isRecurring = false,
    this.isSync = false,
    this.isArchive = false,
    this.createdAt,
    this.notes,
  });

  @override
  String toString() {
    return 'Commitment({name="$name", description="$description", value=$value, label="$label", billingPeriod="$billingPeriod", note="$note", isRecurring=$isRecurring, isSync=$isSync, isArchive=$isArchive, createdAt=$createdAt, notes="$notes",});';
  }
}

enum BillingPeriod {
  daily,
  weekly,
  monthly,
  yearly,
}

const Map<BillingPeriod, String> billPeriod = {
  BillingPeriod.daily: 'Daily',
  BillingPeriod.weekly: 'Weekly',
  BillingPeriod.monthly: 'Monthly',
  BillingPeriod.yearly: 'Yearly',
};
