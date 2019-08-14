import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
//import 'package:speech_to_text_app/bloc/bloc_provider.dart';
import 'package:speech_to_text_app/pages/home/home_widget.dart';
//import 'package:speech_to_text_app/ui/home/home_bloc.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        accentColor: Colors.orange,
        primaryColor: const Color(0xFFDE4435),
      ),
      home: HomePage(),
//        home: BlocProvider(
//          bloc: HomeBloc(),
//          child: HomePage(),
//        )
    );
  }
}
