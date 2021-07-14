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

class Commitment {
  String name; //name of the commitment
  String description; //description of the commitment
  double value = 0.0; //the value of the commitment
  String label; //label of the commitment
  String billingPeriod;
  String note;
  String color;
  bool isCompleted = false;
  bool isRecurring = false; //either it is recurring or not
  bool isSync = false; //either the data is sync

  Commitment({
    this.name,
    this.description,
    this.value,
    this.label,
    this.billingPeriod,
    this.note,
    this.color,
    this.isCompleted,
    this.isRecurring,
    this.isSync,
  });

  @override
  String toString() {
    return 'Commitment({name="$name", description="$description", value=$value, label="$label", billingPeriod="$billingPeriod", note="$note", isRecurring=$isRecurring, isSync=$isSync,});';
  }
}
