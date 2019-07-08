import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
//import 'dart:developer';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Page> pages = _allPages;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: pages.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech To Text'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          indicator: const UnderlineTabIndicator(),
          tabs: pages.map<Tab>((Page page) {
            return Tab(text: page.text);
          }).toList(),
        ),
      ),
      body: TabBarView(
          controller: _controller,
          children: pages.map<Widget>((Page page) {
            return Scaffold(
              key: scaffoldKey,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.edit),
                onPressed: () {
                  scaffoldKey.currentState.showSnackBar(const SnackBar(
                    content: Text('Not supported.'),
                  ));
                },
              ),
              body: CustomScrollView(
//                semanticChildCount: widget.recipes.length,
//                slivers: <Widget>[
//                  _buildAppBar(context, statusBarHeight),
//                  _buildBody(context, statusBarHeight),
//                ],
                  ),
            );
          }).toList()),
    );
  }
}

class Page {
  const Page({this.icon, this.text});
  final IconData icon;
  final String text;
}

const List<Page> _allPages = <Page>[
  Page(icon: Icons.grade, text: 'TRIUMPH'),
  Page(icon: Icons.playlist_add, text: 'NOTE'),
];
