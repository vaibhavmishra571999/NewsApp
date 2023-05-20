import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_demo/utils/keys.dart';

class ApiService {
  static Future<List<dynamic>> getBreakingNews() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=${ApiKeys.apiKey}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final articles = jsonData['articles'] as List<dynamic>;
      return articles;
    } else {
      throw Exception('Failed to load breaking news');
    }
  }

  static Future<List<dynamic>> searchNews(String keyword) async {
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$keyword&apiKey=${ApiKeys.apiKey}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final articles = jsonData['articles'] as List<dynamic>;
      return articles;
    } else {
      throw Exception('Failed to search news');
    }
  }
}
