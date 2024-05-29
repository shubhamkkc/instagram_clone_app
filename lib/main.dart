import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/provider/user_provider.dart';
import 'package:instagram_clone_app/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_app/responsive/responsive_layout.dart';
import 'package:instagram_clone_app/responsive/web_screen_layout.dart';
import 'package:instagram_clone_app/screen/login_screen.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    const apiKey = "AIzaSyDSz6jPyOH1ZvwEamKuG3FHmpsJDe2rNU4";
    const appId = "1:92359009290:web:541ae1c06f62876cf12bf3";
    const messagingSenderId = "92359009290";
    const projectId = "instagram-clone-38231";
    const storageBucket = "instagram-clone-38231.appspot.com";

    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          storageBucket: storageBucket),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp()));
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
        debugShowCheckedModeBanner: false,
        // home: ResponsiveLayout(
        //   MobileScreenLayot: MobileScreenLayot(),
        //   WebScreenLayot: WebScreenLayot(),
        // ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    MobileScreenLayot: MobileScreenLayot(),
                    // MobileScreenLayot: LoginScreen(),
                    WebScreenLayot: WebScreenLayot(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: primaryColor,
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.hasError}'),
                  );
                }
              }

              return const LoginScreen();
            })));
  }
}
