import 'dart:convert';

import 'package:dentalRnD/widgets/newsModel.dart';
import 'package:http/http.dart' as http;

class ApiManager {
//ed559db4d2984cbb9ad09146babcdcd5
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Strings.news_url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}

class Strings {
  static String news_url =
      'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ed559db4d2984cbb9ad09146babcdcd5';
}
