import 'package:flutter/material.dart';
import 'package:instagram_clone_app/provider/user_provider.dart';
import 'package:instagram_clone_app/responsive/dimension.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget MobileScreenLayot;
  final Widget WebScreenLayot;
  const ResponsiveLayout(
      {super.key,
      required this.MobileScreenLayot,
      required this.WebScreenLayot});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hitGetUser();
  }

  hitGetUser() async {
    UserProvider _userProvider = await context.read<UserProvider>();
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > constraintsWidth) {
        return widget.WebScreenLayot;
      } else {
        return widget.MobileScreenLayot;
      }
    });
  }
}
