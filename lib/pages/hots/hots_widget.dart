import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

//import 'package:speech_to_text_app/pages/home/home_drawer.dart';
import 'package:speech_to_text_app/pages/home/home_drawer.dart';
import 'package:speech_to_text_app/models/docs.dart';
import 'package:speech_to_text_app/pages/hots/hots.dart';

class HotsPage extends StatefulWidget {
  @override
  HotsPageState createState() => HotsPageState();
}

class HotsPageState extends State<HotsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: hots.length,
        child: Scaffold(
          drawer: HomeDrawer(),
          appBar: AppBar(
            title: Center(
              child: Text('Tabbed AppBar', textAlign: TextAlign.center),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: hots.map<Widget>((Hot hot) {
                return Tab(text: hot.title);
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: hots.map<Widget>((Hot hot) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: HotCard(hot: hot),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class HotCard extends StatefulWidget {
  HotCard({Key key, this.hot}) : super(key: key);

  final Hot hot;

  @override
  HotCardState createState() => HotCardState();
}

class HotCardState extends State<HotCard> {
  final ScrollController _scroller = ScrollController();

  Future<DocsModel> hots;
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();

    _scroller.addListener(() {
      if (_scroller.position.pixels == _scroller.position.maxScrollExtent) {
        _moreHots();
      }
    });

    hots = getHttp(widget.hot.type);
  }

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  void _moreHots() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);

      final resp = getHttp(widget.hot.type);
      setState(() {
        resp.then((r1) => hots.then((r2) => r2.data.addAll(r1.data)));
        isPerformingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: hots,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return docListView(context, snapshot.data);
        }
      },
    );
  }

  Widget docListView(BuildContext context, DocsModel doc) {
    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(2.0),
      bottomRight: Radius.circular(2.0),
    ));

    return ListView.builder(
      controller: _scroller,
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
                    showAttrPage(context, attr);
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

  void showAttrPage(BuildContext context, DocsAttr attr) {
    Navigator.push(
        context,
//        MaterialPageRoute<void>(
        CupertinoPageRoute<void>(
          fullscreenDialog: false,
          settings: const RouteSettings(name: '/hots/hot'),
          builder: (BuildContext context) {
            return Theme(
              data: _kTheme.copyWith(platform: Theme.of(context).platform),
              child: DocAttrPage(hot: attr),
            );
          },
        ));
  }
}

final ThemeData _kTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  accentColor: Colors.redAccent,
);

const double _kFabHalfSize = 28.0;
const double _khotPageMaxWidth = 500.0;

class PestoStyle extends TextStyle {
  const PestoStyle({
    double fontSize = 12.0,
    FontWeight fontWeight,
    Color color = Colors.black87,
    double letterSpacing,
    double height,
  }) : super(
          inherit: false,
          color: color,
          fontFamily: 'Raleway',
          fontSize: fontSize,
          fontWeight: fontWeight,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: letterSpacing,
          height: height,
        );
}

class DocAttrPage extends StatefulWidget {
  const DocAttrPage({Key key, this.hot}) : super(key: key);

  final DocsAttr hot;

  @override
  _DocAttrPageState createState() => _DocAttrPageState();
}

class _DocAttrPageState extends State<DocAttrPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextStyle menuItemStyle = const PestoStyle(
      fontSize: 15.0, color: Colors.black54, height: 24.0 / 15.0);

  double _getAppBarHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.3;

  @override
  Widget build(BuildContext context) {
    final appBarHeight = _getAppBarHeight(context);
    final screenSize = MediaQuery.of(context).size;
    final fullWidth = screenSize.width < _khotPageMaxWidth;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.orange,
        onPressed: () async {},
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: appBarHeight + _kFabHalfSize,
            child: Hero(
              tag: widget.hot.image.path,
              child: Image.network(
                widget.hot.image.toString(),
                fit: fullWidth ? BoxFit.fitWidth : BoxFit.cover,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: appBarHeight - _kFabHalfSize,
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (String item) {},
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuItem<String>>[
                          _buildMenuItem(Icons.share, 'Tweet hot'),
                          _buildMenuItem(Icons.email, 'Email hot'),
                          _buildMenuItem(Icons.message, 'Message hot'),
                          _buildMenuItem(Icons.people, 'Share on Facebook'),
                        ],
                  ),
                ],
                flexibleSpace: const FlexibleSpaceBar(
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.2),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: _kFabHalfSize),
                      width: fullWidth ? null : _khotPageMaxWidth,
                      child: DocAttrSheet(hot: widget.hot),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
    return PopupMenuItem<String>(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(icon, color: Colors.black54),
          ),
          Text(label, style: menuItemStyle),
        ],
      ),
    );
  }
}

class DocAttrSheet extends StatelessWidget {
  DocAttrSheet({Key key, this.hot}) : super(key: key);

  final TextStyle titleStyle = const PestoStyle(fontSize: 34.0);
  final TextStyle descriptionStyle = const PestoStyle(
      fontSize: 15.0, color: Colors.black54, height: 24.0 / 15.0);
  final TextStyle itemStyle =
      const PestoStyle(fontSize: 15.0, height: 24.0 / 15.0);
  final TextStyle itemAmountStyle = PestoStyle(
      fontSize: 15.0, color: _kTheme.primaryColor, height: 24.0 / 15.0);
  final TextStyle headingStyle = const PestoStyle(
      fontSize: 16.0, fontWeight: FontWeight.bold, height: 24.0 / 15.0);

  final DocsAttr hot;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Table(columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(0.0),
          }, children: <TableRow>[
            TableRow(children: <Widget>[
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: const SizedBox(),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(hot.title, style: titleStyle),
              ),
            ]),
            TableRow(children: <Widget>[
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Text(hot.title, style: descriptionStyle),
              ),
            ]),
            TableRow(children: <Widget>[
              const SizedBox(),
              RaisedButton(
                  child: Text('View Next'),
                  onPressed: () {
                    showWebView(context, hot);
                  }),
            ]),
          ]),
        ),
      ),
    );
  }

  void showWebView(BuildContext context, DocsAttr hot) {
    Navigator.push(
        context,
//        MaterialPageRoute<void>(
        CupertinoPageRoute<void>(
          fullscreenDialog: false,
          settings: RouteSettings(name: '/hots/hot/webview'),
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Center(
                  child: Text(hot.title, textAlign: TextAlign.left),
                ),
              ),
              body: WebView(initialUrl: hot.url.toString()),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.orange,
                onPressed: () async {},
              ),
            );
          },
        ));
  }
}
