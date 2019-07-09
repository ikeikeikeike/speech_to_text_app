import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'home.dart';

const double _kHomePageMaxWidth = 500.0;
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

const List<HomePage> _allPages = <HomePage>[
  HomePage(
    icon: Icons.grade,
    text: 'TRIUMPH',
    imagePath: 'food/spinach_onion_salad.png',
    imagePackage: _kGalleryAssetsPackage,
  ),
  HomePage(
    icon: Icons.playlist_add,
    text: 'NOTE',
    imagePath: 'food/spinach_onion_salad.png',
    imagePackage: _kGalleryAssetsPackage,
  ),
];

class HomeWidget extends StatefulWidget {
  static const String routeName = '/home';

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List<HomePage> pages = _allPages;

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
          tabs: pages.map<Tab>((HomePage page) {
            return Tab(text: page.text);
          }).toList(),
        ),
      ),
      body: TabBarView(
          controller: _controller,
          children: pages.map<Widget>((HomePage page) {
            final statusBarHeight = MediaQuery.of(context).padding.top;
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
                semanticChildCount: pages.length,
                slivers: <Widget>[
//                  _buildAppBar(context, statusBarHeight),
                  _buildBody(context, statusBarHeight),
                ],
              ),
            );
          }).toList()),
    );
  }

  Widget _buildBody(BuildContext context, double statusBarHeight) {
    final mediaPadding = MediaQuery.of(context).padding;
    final padding = EdgeInsets.only(
      top: 8.0,
      left: 8.0 + mediaPadding.left,
      right: 8.0 + mediaPadding.right,
      bottom: 8.0,
    );
    return SliverPadding(
      padding: padding,
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: _kHomePageMaxWidth,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final page = pages[index];
            return HomeCard(
              page: page,
//              onTap: () { showHomePage(context, page); },
            );
          },
          childCount: pages.length,
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({Key key, this.page, this.onTap}) : super(key: key);

  final HomePage page;
  final VoidCallback onTap;

  TextStyle get titleStyle =>
      const HomeStyle(fontSize: 24.0, fontWeight: FontWeight.w600);
  TextStyle get authorStyle =>
      const HomeStyle(fontWeight: FontWeight.w500, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'packages/$_kGalleryAssetsPackage/${page.imagePath}',
              child: AspectRatio(
                aspectRatio: 4.0 / 3.0,
                child: Image.asset(
                  page.imagePath,
                  package: page.imagePackage,
                  fit: BoxFit.cover,
                  semanticLabel: page.text,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      page.imagePackage,
                      package: page.imagePackage,
                      width: 48.0,
                      height: 48.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(page.text,
                            style: titleStyle,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                        Text(page.text, style: authorStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
