import '../models/post_model.dart';

class PostController {
  List<PostModel> fetchPosts() {
    return [
      PostModel(
        username: "iiamcharlie",
        imageUrl: "https://coveredgeekly.com/wp-content/uploads/Top-15-Most-Beautiful-Female-Celebrities-Actresses-of-2023-According-to-Polls-Image-3-1024x549.jpg",
        caption: "Felt Cute!....",
        likes: 10,
        comments: 0,
        timeAgo: "3 days ago",
      ),
      PostModel(
        username: "anotheruser",
        imageUrl: "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-madebymath-90946.jpg&fm=jpg",
        caption: "A beautiful view!",
        likes: 10,
        comments: 2,
        timeAgo: "2 days ago",
      ),
      PostModel(
        username: "anotheruser",
        imageUrl: "https://coveredgeekly.com/wp-content/uploads/Top-15-Most-Beautiful-Female-Celebrities-Actresses-of-2023-According-to-Polls-Image-3-1024x549.jpg",
        caption: "A beautiful view!",
        likes: 10,
        comments: 2,
        timeAgo: "2 days ago",
      ),
      PostModel(
        username: "anotheruser",
        imageUrl: "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?cs=srgb&dl=pexels-madebymath-90946.jpg&fm=jpg",
        caption: "A beautiful view!",
        likes: 10,
        comments: 2,
        timeAgo: "2 days ago",
      ),
      
    ];
  }
}
