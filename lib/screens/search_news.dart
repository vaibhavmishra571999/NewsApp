import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_demo/apiService/http_services.dart';
import 'package:news_app_demo/controller/news_controller.dart';
import 'package:news_app_demo/utils/time_util.dart';

class SearchNewsScreen extends GetView<NewsController> {
  final _searchController = TextEditingController();

  @override
  final controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search News'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                controller.searchText.value = value;
                controller.searchNews(value);
              },
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Obx(
            () {
              if (controller.searchLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.searchText.value != '' &&
                  controller.searchResults.isEmpty) {
                return const Center(
                  child: Text("No Data Found"),
                );
              } else {
                return Expanded(
                    child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final article = controller.searchResults[index];
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          article['urlToImage'] ?? ''),
                                      fit: BoxFit.cover))),
                          Text(
                              convertToLocaleTime(article['publishedAt'] ?? ''))
                        ],
                      ),
                      title: Text(
                        article['title'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        article['description'] ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
