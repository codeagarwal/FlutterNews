import 'dart:convert';

import 'package:flutter_news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=5997f13d9f1945ca9ca1a718c859d93b");

    var responce = await http.get(url);
    var jsonData = jsonDecode(responce.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element['content'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}
