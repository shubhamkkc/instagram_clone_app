import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_app/models/user.dart' as model;
import 'package:instagram_clone_app/resourcre/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get user details
  Future<model.User> getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return model.User.fromSnap(snap);
  }

  //signup user
  Future<String> signupUser(
      {required String username,
      required String email,
      required String password,
      required String bio,
      required Uint8List file}) async {
    String res = "something is wrong";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final imageUrl =
            await StroageMethod().uploadImageStroage("profilePic", file, false);
        model.User user = model.User(
            uid: cred.user!.uid,
            username: username,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: imageUrl,
            email: email,
            password: password);
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// login user
  Future<String> loginUser({required email, required password}) async {
    String res = "something is wrong";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "sucess";
      print("login successful");
    } catch (err) {
      res = err.toString();
      print(res);
    }
    return res;
  }
}
