import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed_app/Views/profile_view.dart';
import 'package:social_media_feed_app/Views/widgets/post_widget.dart';
import 'package:social_media_feed_app/models/post_model.dart';
import 'add_post_view.dart';
import 'notifications_view.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/story_widget.dart';
import '../Controllers/post_controller.dart';

class HomeView extends GetView<PostController> {
  HomeView({super.key});

  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _pages = [
    Center(child: Text("Home")),
    AddPostView(),
    NotificationsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("Social Media Feed"),
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
          actions: const [
            Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
              size: 25,
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Obx(() {
          return _selectedIndex.value == 0
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No posts available."));
                    }

                    final posts = snapshot.data!.docs
                        .map((doc) => PostModel.fromDocument(doc))
                        .toList();

                    return ListView(
                      children: [
                        StoryWidget(),
                        ...posts.map((post) => PostWidget(post: post)),
                      ],
                    );
                  },
                )
              : _pages[_selectedIndex.value];
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavBar(
            selectedIndex: _selectedIndex.value,
            onItemSelected: (index) {
              _selectedIndex.value = index;
            },
          );
        }));
  }
}
