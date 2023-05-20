import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_demo/apiService/http_services.dart';
import 'package:news_app_demo/controller/news_controller.dart';
import 'package:news_app_demo/utils/time_util.dart';

class BreakingNewsScreen extends GetView<NewsController> {
  BreakingNewsScreen({super.key});

  @override
  final controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Breaking News'),
        ),
        body: Obx(
          () {
            if (controller.breakingLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.breakingNews.isEmpty) {
              return const Center(child: Text('Failed to load breaking news'));
            } else {
              List articles = controller.breakingNews;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
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
                        Text(convertToLocaleTime(article['publishedAt'] ?? ''))
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
              );
            }
          },
        ));
  }
}
