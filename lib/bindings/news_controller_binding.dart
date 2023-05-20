import 'package:get/get.dart';
import 'package:news_app_demo/controller/news_controller.dart';

class NewsBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NewsController>(() => NewsController());
  }
}
