import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
//import 'dart:developer';

const double _kRecipePageMaxWidth = 500.0;
const String _kSmallLogoImage = 'logos/pesto/logo_small.png';
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';
const double _kAppBarHeight = 128.0;
const double _kFabHalfSize = 28.0;

final Set<Page> _favoriteRecipes = <Page>{};

final ThemeData _kTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  accentColor: Colors.redAccent,
);

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
          maxCrossAxisExtent: _kRecipePageMaxWidth,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final page = pages[index];
            return RecipeCard(
              recipe: page,
//              onTap: () { showRecipePage(context, page); },
            );
          },
          childCount: pages.length,
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({Key key, this.recipe, this.onTap}) : super(key: key);

  final Page recipe;
  final VoidCallback onTap;

  TextStyle get titleStyle =>
      const PestoStyle(fontSize: 24.0, fontWeight: FontWeight.w600);
  TextStyle get authorStyle =>
      const PestoStyle(fontWeight: FontWeight.w500, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'packages/$_kGalleryAssetsPackage/${recipe.imagePath}',
              child: AspectRatio(
                aspectRatio: 4.0 / 3.0,
                child: Image.asset(
                  recipe.imagePath,
                  package: recipe.imagePackage,
                  fit: BoxFit.cover,
                  semanticLabel: recipe.text,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      recipe.imagePackage,
                      package: recipe.imagePackage,
                      width: 48.0,
                      height: 48.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(recipe.text,
                            style: titleStyle,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                        Text(recipe.text, style: authorStyle),
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

class Page {
  const Page({
    this.icon,
    this.text,
    this.imagePath,
    this.imagePackage,
  });
  final IconData icon;
  final String text;
  final String imagePath;
  final String imagePackage;
}

const List<Page> _allPages = <Page>[
  Page(
    icon: Icons.grade,
    text: 'TRIUMPH',
    imagePath: 'food/spinach_onion_salad.png',
    imagePackage: _kGalleryAssetsPackage,
  ),
  Page(
    icon: Icons.playlist_add,
    text: 'NOTE',
    imagePath: 'food/spinach_onion_salad.png',
    imagePackage: _kGalleryAssetsPackage,
  ),
];
