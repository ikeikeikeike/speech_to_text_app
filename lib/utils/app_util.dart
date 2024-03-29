import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speech_to_text_app/utils/app_constant.dart';

void showSnackbar(GlobalKey<ScaffoldState> scaffoldState, String message,
    {MaterialColor materialColor}) {
  if (message.isEmpty) {
    return;
  }
  // Find the Scaffold in the Widget tree and use it to show a SnackBar
  scaffoldState.currentState.showSnackBar(
      SnackBar(content: Text(message), backgroundColor: materialColor));
}

void launchURL(String url) async {
  if (url.isEmpty) {
    return;
  }
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw ArgumentError('Could not launch $url');
  }
}

class MessageInCenterWidget extends StatelessWidget {
  const MessageInCenterWidget(this._message);

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_message,
          style: TextStyle(fontSize: FONT_MEDIUM, color: Colors.black)),
    );
  }
}
