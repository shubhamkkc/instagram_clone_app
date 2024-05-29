class Post {
  final String uid;
  final String caption;
  final String postImageUrl;
  final String profileImage;
  final String userName;
  final String postId;
  final date;
  final likes;

  const Post({
    required this.uid,
    required this.caption,
    required this.postImageUrl,
    required this.profileImage,
    required this.userName,
    required this.postId,
    required this.date,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "caption": caption,
        "postImageUrl": postImageUrl,
        "profileImage": profileImage,
        "userName": userName,
        "postId": postId,
        "date": date,
        "like": likes
      };
}
