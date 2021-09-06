import 'package:commitment_tracker/common/utils/route_generator.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacementNamed(context, Routes.home),
      child: Scaffold(
        appBar: AppBar(title: Text('Logout Screen')),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text("You have been logout!"),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.home);
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
