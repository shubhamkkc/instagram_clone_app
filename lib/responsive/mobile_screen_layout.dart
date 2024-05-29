import 'package:flutter/material.dart';
import 'package:instagram_clone_app/models/user.dart';
import 'package:instagram_clone_app/provider/user_provider.dart';
import 'package:instagram_clone_app/screen/feed_screen.dart';
import 'package:instagram_clone_app/screen/post_screen.dart';
import 'package:instagram_clone_app/screen/profile_screen.dart';
import 'package:instagram_clone_app/screen/search_screen.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayot extends StatefulWidget {
  const MobileScreenLayot({super.key});

  @override
  State<MobileScreenLayot> createState() => _MobileScreenLayotState();
}

class _MobileScreenLayotState extends State<MobileScreenLayot> {
  int _page = 0;
  final List<Widget> pages = [
    FeedScreen(),
    SearchScreen(),
    PostScreen(),
    Text("fav"),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _page, children: pages),
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 35,
          currentIndex: _page,
          onTap: (value) => setState(() {
                _page = value;
              }),
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _page == 0 ? Icons.home_filled : Icons.home_outlined,
                color: primaryColor,
              ),
              backgroundColor: mobileBackgroundColor,
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 1 ? Icons.search : Icons.search_outlined,
                color: primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
                color: primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 3 ? Icons.favorite : Icons.favorite_border,
                color: primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 4 ? Icons.person : Icons.person_2_outlined,
                color: primaryColor,
              ),
              label: '',
            ),
          ]),
    );
  }
}
