import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddPostController extends GetxController {
  var selectedImage = Rxn<XFile>();
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> addPost(String description, String location) async {
    if (selectedImage.value == null || description.isEmpty || location.isEmpty) {
      Get.snackbar("Error", "Please fill all fields and select an image");
      return;
    }

    try {
      final imageUrl = await _uploadImage(File(selectedImage.value!.path));
      if (imageUrl == null) return;

      final postData = {
        "title": "Muniasamy K",
        "imageUrl": imageUrl,
        "location": location,
        "description": description,
        "likes": 0,
        "isLiked": false,
        "isSaved": false,
        "time": FieldValue.serverTimestamp(),
        "comments": [],
      };

      await FirebaseFirestore.instance.collection('posts').add(postData);

      Get.defaultDialog(
        contentPadding: EdgeInsets.only(bottom: 20,left: 20,top: 10,right: 20),
        titlePadding: EdgeInsets.only(top: 20),
        title: "Success",
        middleText: "Post added successfully!",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to add post: $e");
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef =
          storageRef.child('post_images/${DateTime.now().toIso8601String()}');
      await imageRef.putFile(image);
      return await imageRef.getDownloadURL();
    } catch (e) {
      Get.snackbar("Error", "Failed to upload image: $e");
      return null;
    }
  }
}
