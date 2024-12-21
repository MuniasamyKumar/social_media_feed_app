import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed_app/Controllers/post_controller.dart';
import '../../models/post_model.dart';

class PostWidget extends GetView<PostController> {
  final PostModel post;

   PostWidget({super.key, required this.post});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1689539137236-b68e436248de?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGVyc29ufGVufDB8fDB8fHww'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(post.location),
                  ],
                ),
              ],
            ),
          ),
          Image.network(post.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,color: Colors.red,),
                    onPressed: () {
                      controller.toggleLike(post);
                    },
                  ),
                  Text("${post.likes}"),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline_outlined,color: Colors.black,),
                    onPressed: () {
                      _showCommentsBottomSheet(context);
                    },
                  ),
                  Text("${post.comments.length}"),
                  IconButton(onPressed: () {
                    
                  }, icon: Icon(Icons.share,color: Colors.black,)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                      post.isSaved ? Icons.bookmark : Icons.bookmark_border,color: Colors.black,),
                  onPressed: () {
                    controller.toggleSave(post);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Text(
              _getTimeAgo(post.time),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

void _showCommentsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Comments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
             
              SizedBox(
                height: 300, 
                child: ListView.builder(
                  itemCount: post.comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(post.comments[index].toString()),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              TextField( 
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: "Add a comment",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String comment = _commentController.text.trim();
                      if (comment.isNotEmpty) {
                        controller.addComment(post, comment);
                        _commentController.clear();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}



  String _getTimeAgo(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}
