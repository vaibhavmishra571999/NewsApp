import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_demo/apiService/http_services.dart';

class NewsController extends GetxController {
  final _breakingNews = <dynamic>[].obs;
  final _searchResults = <dynamic>[].obs;
  RxBool breakingLoading = true.obs;
  RxBool searchLoading = false.obs;
  RxString searchText = ''.obs;

  List<dynamic> get breakingNews => _breakingNews;
  List<dynamic> get searchResults => _searchResults;

  @override
  void onInit() {
    super.onInit();
    loadBreakingNews();
  }

  Future<void> loadBreakingNews() async {
    try {
      final news = await ApiService.getBreakingNews();
      _breakingNews.value = news;
    } catch (e) {
      print('Failed to load breaking news: $e');
    } finally {
      breakingLoading(false);
    }
  }

  Future<void> searchNews(String keyword) async {
    try {
      if (keyword.isNotEmpty) {
        final results = await ApiService.searchNews(keyword);
        _searchResults.value = results;
      } else {
        _searchResults.value = [];
      }
    } catch (e) {
      debugPrint('Failed to search news: $e');
    } finally {
      (searchLoading(false));
    }
  }
}
