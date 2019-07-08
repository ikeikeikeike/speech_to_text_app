import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 1
        appBar: AppBar(
          title: const Text('Screen 2'), // screen title
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/screen3');
            },
            child: const Text('Go to Screen 3 profile'),
          ),
        ));
  }
}
