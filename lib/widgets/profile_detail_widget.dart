import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileDetailWidget extends StatelessWidget {
  final int count;
  final String countDetail;

  const ProfileDetailWidget(
      {required this.count, required this.countDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(count as String), Text(countDetail)],
    );
  }
}
