import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String password;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;
  const User({
    required this.uid,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoUrl,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "password": password,
        "bio": bio,
        "followers": [],
        "following": [],
        "photoUrl": photoUrl
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapShot = (snap.data() as Map<String, dynamic>);
    return User(
        uid: snapShot['uid'],
        username: snapShot['username'],
        bio: snapShot['bio'],
        followers: snapShot['followers'],
        following: snapShot['following'],
        photoUrl: snapShot['photoUrl'],
        email: snapShot['email'],
        password: snapShot['password']);
  }
}
