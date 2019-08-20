import 'package:flutter/material.dart';
import 'package:speech_to_text_app/models/docs.dart';
import 'package:speech_to_text_app/utils/app_constant.dart';
import 'package:speech_to_text_app/utils/app_util.dart';

class AddDoc extends StatelessWidget {
  AddDoc({Key key, this.attr}) : super(key: key);

  final DocsAttr attr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('チェック', style: TextStyle(fontSize: 16.0)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: attr.title,
                        hintText: 'Enter your text here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text('Socials',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Image.asset(
                              'assets/twitter_logo.png',
                              scale: 8.75,
                            ),
                            onPressed: () => launchURL(TWITTER_URL),
                          ),
                          IconButton(
                            icon: Image.asset('assets/facebook_logo.png'),
                            onPressed: () => launchURL(FACEBOOK_URL),
                          ),
                          Spacer(),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('CHECK'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
