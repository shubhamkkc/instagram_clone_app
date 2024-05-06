import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_app/resourcre/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
        await _firestore.collection("users").doc(cred.user!.uid).set({
          "uid": cred.user!.uid,
          "username": username,
          "email": email,
          "password": password,
          "bio": bio,
          "followers": [],
          "following": [],
          "file": imageUrl
        });
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
