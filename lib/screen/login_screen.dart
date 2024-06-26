import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_app/resourcre/auth_method.dart';
import 'package:instagram_clone_app/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_app/responsive/responsive_layout.dart';
import 'package:instagram_clone_app/responsive/web_screen_layout.dart';
import 'package:instagram_clone_app/screen/signup_screen.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:instagram_clone_app/utils/utils.dart';
import 'package:instagram_clone_app/widgets/input_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  Future<void> logIn() async {
    setState(() {
      isloading = true;
    });
    String loginResp = await AuthMethod()
        .loginUser(email: email.text, password: password.text);
    setState(() {
      isloading = false;
    });
    if (loginResp == "sucess") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                MobileScreenLayot: MobileScreenLayot(),
                WebScreenLayot: WebScreenLayot(),
              )));
    } else {
      showSnackbar(context, loginResp);
    }
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    SvgPicture.asset(
                      "assets/images/ic_instagram.svg",
                      height: 50,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFieldInput(
                      keyboardType: TextInputType.text,
                      controller: email,
                      hintText: "Enter Your email",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFieldInput(
                      keyboardType: TextInputType.text,
                      controller: password,
                      hintText: "Enter Your Password",
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: blueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust the radius as needed
                              ),
                            ),
                            onPressed: () {
                              logIn();
                              //  Navigator.of(context).push(route)
                            },
                            child: isloading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Log In"))),
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't Have an Account?"),
                        TextButton(
                          onPressed: () {
                            navigateToSignup();
                          },
                          child: const Text("Sign Up"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
