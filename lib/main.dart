import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_demo/screens/breaking_news.dart';
import 'package:news_app_demo/screens/search_news.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News Discovery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsDiscoveryScreen(),
    );
  }
}

class NewsDiscoveryScreen extends StatefulWidget {
  const NewsDiscoveryScreen({super.key});

  @override
  _NewsDiscoveryScreenState createState() => _NewsDiscoveryScreenState();
}

class _NewsDiscoveryScreenState extends State<NewsDiscoveryScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          BreakingNewsScreen(),
          SearchNewsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: 'Breaking News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search News',
          ),
        ],
      ),
    );
  }
}
