import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:speech_to_text_app/models/docs.dart';

class HotsPage extends StatefulWidget {
  @override
  HotsPageState createState() => HotsPageState();
}

class HotsPageState extends State<HotsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer()),
            title: Text('Tabbed AppBar'),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map<Widget>((Choice choice) {
                return Tab(text: choice.title);
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map<Widget>((Choice choice) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.type, this.icon});
  final String title;
  final String type;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'ARTICLE', type: 'article', icon: Icons.directions_car),
  Choice(title: 'BLOG', type: 'blog', icon: Icons.directions_bike),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
            GestureDetector(
                child: Text('Click here',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue)),
                onTap: () async {
                  final unko = await getHttp(choice.type);
                  print(unko);
                }),
          ],
        ),
      ),
    );
  }
}

Future<DocsModel> getHttp(String type) async {
  final url = 'http://192.168.1.9:8000/v1/documents/?type=$type';
  final dio = Dio();

  try {
    final resp = await dio.get(url);
    return DocsModel.fromJson(resp.data);
    // ignore: avoid_catches_without_on_clauses
  } catch (error, stacktrace) {
    print('Exception occured: $error stackTrace: $stacktrace');
    return DocsModel.withError('$error');
  }
}
