class Post {
  final String uid;
  final String caption;
  final String postImageUrl;

  const Post(
      {required this.uid, required this.caption, required this.postImageUrl});

  Map<String, dynamic> toJson() =>
      {"uid": uid, "caption": caption, "postImageUrl": postImageUrl};
}
