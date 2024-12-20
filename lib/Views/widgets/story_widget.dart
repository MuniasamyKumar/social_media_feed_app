import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          StoryCircle(username: "Arun"),
          StoryCircle(username: "Mukilan"),
          StoryCircle(username: "Premji"),
        ],
      ),
    );
  }
}

class StoryCircle extends StatelessWidget {
  final String username;

  StoryCircle({required this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,top: 15),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.purple,
                width: 3
              )
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxLzI3OS1wYWkxNTc5LW5hbS1qb2IxNTI5LnBuZw.png'),
              radius: 30, backgroundColor: Colors.purple,
              
              ),
          ),
          
          SizedBox(height: 5),
          Text(username, style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
