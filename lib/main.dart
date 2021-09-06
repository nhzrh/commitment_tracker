import 'package:commitment_tracker/common/utils/constant.dart';
import 'package:commitment_tracker/common/utils/route_generator.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:commitment_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(CommitmentAdapter());
  await Hive.openBox<Commitment>(Constants.commitmentBox);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Commitment Tracker',
      onGenerateRoute: RouteGenerator.generateRoute,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
