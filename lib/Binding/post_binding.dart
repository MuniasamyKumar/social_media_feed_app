import 'package:get/get.dart';
import 'package:social_media_feed_app/Controllers/post_controller.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    print("InitialBinding.dependencies() called");
     Get.lazyPut<PostController>(() {
      print("PostController added to dependencies");
      return PostController();
    });
  }
}
