import 'package:flutter/foundation.dart';
import 'package:instagram_clone_app/resourcre/auth_method.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      uid: "",
      username: "",
      bio: "",
      followers: [],
      following: [],
      photoUrl: "",
      email: "",
      password: "");
  User get getUser => _user;
  final AuthMethod _authMethod = AuthMethod();

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;

    notifyListeners();
  }
}
