import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api/models/news_model.dart';

class ApiManager {

  var newsURL = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=26c1727387214cea9fcf9d4f68a0387d";
  Future <NewsModel?> getNews() async {
    var client = http.Client();
    var newsModel = null;
    try {
      var response = await client.get(Uri.parse(newsURL));
      if(response.statusCode == 200)
        {
          var jsonString = response.body;
          var jsonMap = json.decode(jsonString);
          newsModel = NewsModel.fromJson(jsonMap);
        }
      return newsModel;
    }
    catch(e)
    {
      return newsModel;
    }
  }
}