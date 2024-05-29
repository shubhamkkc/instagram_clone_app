import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/models/post.dart';
import 'package:instagram_clone_app/models/user.dart';
import 'package:instagram_clone_app/resourcre/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> postUpload(
      {required User user,
      required String caption,
      required Uint8List postImage}) async {
    String res = "something is wrong";
    String postId = Uuid().v1();
    try {
      if (user.uid.isNotEmpty || caption.isNotEmpty || postImage.isNotEmpty) {
        final imageUrl = await StroageMethod()
            .uploadImageStroage("uploadPost", postImage, true);
        Post post = Post(
            uid: user.uid,
            caption: caption,
            postImageUrl: imageUrl,
            profileImage: user.photoUrl,
            userName: user.username,
            postId: postId,
            date: DateTime.now(),
            likes: []);
        await _firestore.collection("posts").doc(postId).set(post.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String uid, String postId, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          "like": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          "like": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> commentPost(String uid, String postId, String comment,
      String userName, String userImage) async {
    String commentId = Uuid().v1();
    try {
      if (comment.isNotEmpty) {
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comment")
            .doc(commentId)
            .set({
          "userImage": userImage,
          "userId": uid,
          "comment": comment,
          "userName": userName,
          "postId": postId,
          "date_published": DateTime.now()
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //delete post
  Future<void> deletePost(String postId) async {
    _firestore.collection("posts").doc(postId).delete().then(
          (doc) => print("post deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}
