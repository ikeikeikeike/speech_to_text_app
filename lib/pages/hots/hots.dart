import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:speech_to_text_app/models/docs.dart';

class Hot {
  const Hot({this.title, this.type, this.icon});
  final String title;
  final String type;
  final IconData icon;
}

const List<Hot> hots = <Hot>[
  Hot(title: 'ARTICLE', type: 'article', icon: Icons.directions_car),
  Hot(title: 'BLOG', type: 'blog', icon: Icons.directions_bike),
];

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
