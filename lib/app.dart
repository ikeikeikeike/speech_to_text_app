import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
//import 'dart:developer';

import 'ui/home/home.dart';
import 'ui/message/message.dart';
import 'ui/profile/profile.dart';

class App extends StatelessWidget {
  static Map<String, WidgetBuilder> routes = {
    Screen3.routeName: (BuildContext context) => Screen3(),
  };

  static Route<BuildContext> _getRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        settings: settings,
        builder: builder,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppTabs(),
      onGenerateRoute: _getRoute,
    );
  }
}

class AppTabs extends StatefulWidget {
  const AppTabs() : super();

  @override
  _AppTabsState createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  List<Widget> tabLayout = [
    Home(),
    Message(),
    Profile(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.mail),
      title: Text('Messages'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Profile'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabLayout[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int idx) {
            setState(() {
              currentIndex = idx;
            });
          },
          currentIndex: currentIndex,
          items: items),
    );
  }
}

class Screen3 extends StatelessWidget {
  static const String routeName = '/screen3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Screen 3'), // screen title
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Back'),
          ),
        ));
  }
}
