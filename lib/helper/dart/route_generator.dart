import 'package:commitment_tracker/models/commitments.dart';
import 'package:commitment_tracker/screens/detail_screens.dart';
import 'package:commitment_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String detail = '/detail';
}

class CommonArgument {
  final Function add;
  final Commitment commitment;

  CommonArgument({
    this.add,
    this.commitment,
  });
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as CommonArgument;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.detail:
        return MaterialPageRoute(
            builder: (_) => DetailScreen(
                  commitment: args.commitment,
                  add: args.add,
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text('ERROR'),
        ),
      ),
    );
  }
}
