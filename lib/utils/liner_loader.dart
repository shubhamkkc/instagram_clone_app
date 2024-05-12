import 'package:flutter/material.dart';

class LinearLoader extends StatelessWidget {
  const LinearLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Customize color as per your theme
      child: const PreferredSize(
        preferredSize: Size.fromHeight(4.0), // Adjust height as needed
        child: LinearProgressIndicator(
          backgroundColor: Colors.white, // Customize background color
          valueColor: AlwaysStoppedAnimation<Color>(
              Colors.blue), // Customize loader color
        ),
      ),
    );
  }
}
