import 'package:commitment_tracker/models/commitments.dart';
import 'package:commitment_tracker/screens/detail_screens.dart';
import 'package:commitment_tracker/screens/home_screen.dart';
import 'package:commitment_tracker/screens/logout_screen.dart';
import 'package:commitment_tracker/screens/page_1.dart';
import 'package:commitment_tracker/screens/view_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String detail = '/detail';
  static const String view = '/view';
  static const String pageOne = '/pageOne';
  static const String logout = '/logout';
}

class CommonArgument {
  final Commitment commitment;
  final String title;

  CommonArgument({
    this.commitment,
    this.title,
  });
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as CommonArgument;

    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.view:
        return MaterialPageRoute(
          builder: (_) => ViewScreen(
            commitment: args.commitment,
          ),
        );
      case Routes.detail:
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            commitment: args.commitment,
          ),
        );
      case Routes.pageOne:
        return MaterialPageRoute(builder: (_) => PageOne(title: args.title));
      case Routes.logout:
        return MaterialPageRoute(builder: (_) => LogoutScreen());
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
