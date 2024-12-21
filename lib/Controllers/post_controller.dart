import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';

class PostController extends GetxController {

  var posts = <PostModel>[].obs;
  var isLoading = true.obs; 

  @override
  void onInit() {
    super.onInit();
    print("PostController initialized");
    fetchPosts(); 
  }


  void fetchPosts() async {
    isLoading(true); 
    FirebaseFirestore.instance.collection('posts').snapshots().listen((snapshot) {
      posts.clear();  
      for (var doc in snapshot.docs) {
        posts.add(PostModel.fromDocument(doc)); 
      }
      isLoading(false); 
    });
  }

 
  void toggleLike(PostModel post) {
    post.isLiked = !post.isLiked;
    post.likes += post.isLiked ? 1 : -1;

    
    FirebaseFirestore.instance.collection('posts').doc(post.id).update({
      'likes': post.likes,
      'isLiked': post.isLiked,
    });
  }

  
  void toggleSave(PostModel post) {
    post.isSaved = !post.isSaved;

    FirebaseFirestore.instance.collection('posts').doc(post.id).update({
      'isSaved': post.isSaved,
    });
  }

  void addComment(PostModel post, String comment) {
    if (comment.isNotEmpty) {
      // Add the comment to the Firestore database
      FirebaseFirestore.instance.collection('posts').doc(post.id).update({
        'comments': FieldValue.arrayUnion([comment]),  // Add the comment to the comments array
        'commentCount': FieldValue.increment(1), // Increment the comment count
      });
    }
  }
}
