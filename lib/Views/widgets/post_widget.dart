import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

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
                CircleAvatar(radius: 22,backgroundColor: Colors.red, backgroundImage: NetworkImage('https://plus.unsplash.com/premium_photo-1689539137236-b68e436248de?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cGVyc29ufGVufDB8fDB8fHww'),),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Muniasamy K",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Chennai, Tamilnadu"),
                  ],
                ),
              ],
            ),
          ),
          Image.network(post.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.caption),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  Text("${post.likes}"),
                  SizedBox(width: 10,),
                   IconButton(
                    icon: Icon(Icons.chat_bubble_outline_outlined),
                    onPressed: () {},
                  ),
                  Text("${post.likes}"),
                  IconButton(onPressed: (){}, icon: Icon(Icons.share))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 10),
            child: Text(post.timeAgo),
          ),
        ],
      ),
    );
  }
}
