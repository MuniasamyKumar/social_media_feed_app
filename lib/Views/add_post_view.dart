import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed_app/Controllers/add_post_controller.dart';

class AddPostView extends GetView<AddPostController> {
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a New Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Post Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.description, color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon:
                      Icon(Icons.location_on_outlined, color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Obx(() {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: controller.selectedImage.value == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate,
                                    size: 50, color: Colors.grey),
                                SizedBox(height: 10),
                                Text(
                                  "Tap to upload an image",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )
                          : Image.file(
                              File(controller.selectedImage.value!.path),
                              fit: BoxFit.cover),
                    ),
                  );
                }),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  controller.addPost(
                    descriptionController.text.trim(),
                    locationController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.purple,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Post",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
