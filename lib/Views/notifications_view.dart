import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "title": "New Like",
      "description": "iiamcharlie liked your post.",
      "time": "5 mins ago",
    },
    {
      "title": "New Follower",
      "description": "iiamcharles started following you.",
      "time": "10 mins ago",
    },
    {
      "title": "Comment",
      "description": "anotheruser commented: 'Awesome pic!'",
      "time": "1 hour ago",
    },
    {
      "title": "Mention",
      "description": "You were mentioned in a post by friendzone.",
      "time": "3 hours ago",
    },
  ];

   NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            title: notifications[index]["title"]!,
            description: notifications[index]["description"]!,
            time: notifications[index]["time"]!,
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const NotificationCard({super.key, 
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple[100],
          child: Icon(Icons.notifications, color: Colors.purple),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(description),
            SizedBox(height: 8),
            Text(
              time,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
