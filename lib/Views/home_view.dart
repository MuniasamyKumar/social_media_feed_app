import 'package:flutter/material.dart';
import 'package:social_media_feed_app/Views/profile_view.dart';
import 'package:social_media_feed_app/Views/widgets/post_widget.dart';
import '../controllers/post_controller.dart';
import '../models/post_model.dart';
import 'add_post_view.dart';
import 'notifications_view.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/story_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  late List<PostModel> posts;
  final PostController _postController = PostController();

  @override
  void initState() {
    super.initState();
    posts = _postController.fetchPosts();
  }

  final List<Widget> _pages = [
    Center(child: Text("Home")),
    AddPostView(),
    NotificationsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:  AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Social Media Feed"),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined)),
        actions: [
          const Icon(
            Icons.notifications_none_rounded,
            color: Colors.black,
            size: 25,
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: _selectedIndex == 0
          ? ListView(
              children: [
                StoryWidget(),
                ...posts.map((post) => PostWidget(post: post)),
              ],
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
