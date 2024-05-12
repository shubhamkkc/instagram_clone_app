import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone_app/models/post.dart';
import 'package:instagram_clone_app/resourcre/storage_method.dart';

class PostMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> postUpload(
      {required String uid,
      required String caption,
      required Uint8List postImage}) async {
    String res = "something is wrong";
    try {
      if (uid.isNotEmpty || caption.isNotEmpty || postImage.isNotEmpty) {
        final imageUrl = await StroageMethod()
            .uploadImageStroage("uploadPost", postImage, true);
        Post post = Post(uid: uid, caption: caption, postImageUrl: imageUrl);
        await _firestore.collection("posts").doc(uid).set(post.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
