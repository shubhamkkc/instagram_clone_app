import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_app/responsive/responsive-layout.dart';
import 'package:instagram_clone_app/responsive/web_screen_layout.dart';
import 'package:instagram_clone_app/screen/login_screen.dart';
import 'package:instagram_clone_app/screen/signup_screen.dart';
import 'package:instagram_clone_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    const apiKey = "AIzaSyDSz6jPyOH1ZvwEamKuG3FHmpsJDe2rNU4";
    const appId = "1:92359009290:web:541ae1c06f62876cf12bf3";
    const messagingSenderId = "92359009290";
    const projectId = "instagram-clone-38231";
    const storageBucket = "instagram-clone-38231.appspot.com";

    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          storageBucket: storageBucket),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram app',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
        useMaterial3: true,
      ),
      // home: ResponsiveLayout(
      //   MobileScreenLayot: MobileScreenLayot(),
      //   WebScreenLayot: WebScreenLayot(),
      // ),
      home: LoginScreen(),
    );
  }
}
