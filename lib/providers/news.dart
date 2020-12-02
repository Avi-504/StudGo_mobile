import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class News with ChangeNotifier {
  static const url =
      'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty';

  List newsId = [];

  List get news {
    return [...newsId];
  }

  void getNewsId() async {
    final doc = await http.get(url);
    newsId = json.decode(doc.body) as List;
    notifyListeners();
  }
}
