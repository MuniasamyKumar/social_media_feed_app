import 'package:get/get.dart';
import 'package:social_media_feed_app/Controllers/add_post_controller.dart';
import 'package:social_media_feed_app/Controllers/post_controller.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    print("InitialBinding.dependencies() called");
     Get.lazyPut<PostController>(() {
      return PostController();
    });
     Get.lazyPut<AddPostController>(() {
      return AddPostController();
    });
  }
}
