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
    return FutureBuilder(
      future: getHttp(choice.type),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return docListView(context, snapshot);
        }
      },
    );
  }

  Widget docListView(BuildContext context, AsyncSnapshot snapshot) {
    final DocsModel doc = snapshot.data;

    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(2.0),
      bottomRight: Radius.circular(2.0),
    ));

    return ListView.builder(
      itemCount: doc.data.length,
      itemBuilder: (BuildContext context, int index) {
        final attr = doc.data[index];

        return Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {
                    print('Card was tapped');
                  },
                  splashColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  highlightColor: Colors.transparent,
                  child: docCard(context, attr),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget docCard(BuildContext context, DocsAttr attr) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subhead;

    final children = <Widget>[
      SizedBox(
        height: 184.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Ink.image(
                image: NetworkImage(attr.image.toString()),
                fit: BoxFit.cover,
                child: Container(),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  attr.title,
                  style: titleStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      // Description and share/explore buttons.
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: DefaultTextStyle(
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: descriptionStyle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // three line description
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  attr.title,
                  style: descriptionStyle.copyWith(color: Colors.black54),
                ),
              ),
              Text(attr.documentType),
              Text(attr.subtype),
            ],
          ),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
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
