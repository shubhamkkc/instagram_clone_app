import 'package:flutter/material.dart';
import 'package:instagram_clone_app/responsive/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget MobileScreenLayot;
  final Widget WebScreenLayot;
  const ResponsiveLayout(
      {super.key,
      required this.MobileScreenLayot,
      required this.WebScreenLayot});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > constraintsWidth) {
        return WebScreenLayot;
      } else {
        return MobileScreenLayot;
      }
    });
  }
}
