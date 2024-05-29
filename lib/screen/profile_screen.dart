import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:instagram_clone_app/widgets/profile_detail_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("UserName"),
        centerTitle: false,
      ),
      body: Column(children: [
        Row(
          children: [
            CircleAvatar(),
            ProfileDetailWidget(
              count: 1,
              countDetail: 'Posts',
            ),
            ProfileDetailWidget(
              count: 1,
              countDetail: 'Followers',
            ),
            ProfileDetailWidget(
              count: 1,
              countDetail: 'Following',
            ),
          ],
        ),
        Text("UserName"),
        Text("bio"),
      ]),
    );
  }
}
