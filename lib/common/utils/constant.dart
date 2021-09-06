import 'package:commitment_tracker/models/month_model.dart';

class Constants {
  static const commitmentBox = 'commitments';
  static const skEmail = 'email';
  static const skPassword = 'password';
  static List<MonthModel> getMonthModel() => [
        MonthModel('January', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('February', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('March', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('April', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('May', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('June', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('July', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('August', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('September', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('October', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('November', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
        MonthModel('December', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
      ];
}
