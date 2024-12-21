import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_feed_app/Services/notification_service.dart';
import '../models/post_model.dart';

class PostController extends GetxController {
  var posts = <PostModel>[].obs;
  var likedPosts = <PostModel>[].obs;
  var savedPosts = <PostModel>[].obs;
  var isLoading = true.obs;
  var profileImageUrl = RxString(
      "https://plus.unsplash.com/premium_photo-1689539137236-b68e436248de?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGVyc29ufGVufDB8fDB8fHww");

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // print("PostController initialized");
    fetchPosts();
  }

  void fetchPosts() async {
    isLoading(true);
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((snapshot) {
      posts.clear();
      likedPosts.clear();
      savedPosts.clear();
      for (var doc in snapshot.docs) {
        var post = PostModel.fromDocument(doc);
        posts.add(post);
        if (post.isLiked) likedPosts.add(post);
        if (post.isSaved) savedPosts.add(post);
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
    if (post.isLiked) {
      FirebaseFirestore.instance.collection('notifications').add({
        'title': 'Post Liked!',
        'body': '${post.title} was liked by a user.',
        'time': FieldValue.serverTimestamp(),
      });

      NotificationService.display(RemoteMessage(
        notification: RemoteNotification(
          title: 'Post Liked!',
          body: 'One person liked your picture.',
        ),
      ));
    }

    fetchPosts();
  }

  void toggleSave(PostModel post) {
    post.isSaved = !post.isSaved;

    FirebaseFirestore.instance.collection('posts').doc(post.id).update({
      'isSaved': post.isSaved,
    });
    fetchPosts();
  }

  void addComment(PostModel post, String comment) {
    if (comment.isNotEmpty) {
      FirebaseFirestore.instance.collection('posts').doc(post.id).update({
        'comments': FieldValue.arrayUnion([comment]),
        'commentCount': FieldValue.increment(1),
      });

      FirebaseFirestore.instance.collection('notifications').add({
        'title': 'New Comment!',
        'body': 'A new comment was added to your post: $comment',
        'time': FieldValue.serverTimestamp(),
      });

      NotificationService.display(RemoteMessage(
        notification: RemoteNotification(
          title: 'New Comment',
          body: 'You received a new comment on your post!',
        ),
      ));
    }
  }

  void pickProfileImage() async {
    Get.snackbar("Uploading", "Profile image upload started.");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String? imageUrl = await _uploadProfileImage(File(image.path));
      if (imageUrl != null) {
        profileImageUrl.value = imageUrl;
        await _updateProfileImageInFirestore(imageUrl);
        Get.snackbar("Success", "Profile image updated.");
      } else {
        Get.snackbar("Error", "Failed to update profile image.");
      }
    }
  }

  Future<String?> _uploadProfileImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef
          .child('profile_images/${DateTime.now().toIso8601String()}');
      await imageRef.putFile(image);
      return await imageRef.getDownloadURL();
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
      return null;
    }
  }

  Future<void> _updateProfileImageInFirestore(String imageUrl) async {
    try {
      String userId = 'userId';
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profileImage': imageUrl,
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile image in Firestore: $e");
    }
  }
}
