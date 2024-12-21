import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String imageUrl;
  String title;
  String location;
  String description;
  int likes;
  bool isLiked;
  bool isSaved;
  DateTime time;
  List<String> comments;

  PostModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.description,
    required this.likes,
    required this.isLiked,
    required this.isSaved,
    required this.time,
    required this.comments,
  });

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return PostModel(
        id: doc.id,
        imageUrl: data['imageUrl'] ?? '',
        title: data['title'] ?? '',
        location: data['location'] ?? '',
        description: data['description'] ?? '',
        likes: data['likes'] ?? 0,
        isLiked: data['isLiked'] ?? false,
        isSaved: data['isSaved'] ?? false,
        time: (data['time'] as Timestamp).toDate(),
        comments: List<String>.from(data['comments'] ?? []));
  }
}
