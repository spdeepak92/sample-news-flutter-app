import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/latest_news.dart';

class LatestNewsProvider extends ChangeNotifier {
  String apiUrl = 'api.nytimes.com';

  Future<List<LatestNewsModel>?> fetchData(String section) async {
    var url = Uri.parse(
        'https://api.nytimes.com/svc/topstories/v2/${section.toLowerCase()}.json?api-key=ik6mAcGbd9zUbgXzntFaG1itsIVE8Zwe');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = convert.jsonDecode(response.body)['results'];
      List<LatestNewsModel> newsList = jsonResponse
          .map(
            (dynamic item) => LatestNewsModel.fromJson(item),
          )
          .toList();
      return newsList;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
