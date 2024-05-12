import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/resourcre/auth_method.dart';
import 'package:instagram_clone_app/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_app/responsive/responsive_layout.dart';
import 'package:instagram_clone_app/responsive/web_screen_layout.dart';
import 'package:instagram_clone_app/screen/login_screen.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:instagram_clone_app/utils/utils.dart';
import 'package:instagram_clone_app/widgets/input_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController bio = TextEditingController();
  Uint8List? _image;
  bool isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    userName.dispose();
    bio.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void sinUpUser() async {
    setState(() {
      isloading = true;
    });
    if (_image != null) {
      String res = await AuthMethod().signupUser(
          username: userName.text,
          email: email.text,
          password: password.text,
          bio: bio.text,
          file: _image!);

      print(res);
      if (res != "success") {
        showSnackbar(context, res);
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  MobileScreenLayot: MobileScreenLayot(),
                  WebScreenLayot: WebScreenLayot(),
                )));
      }
    }
    setState(() {
      isloading = false;
    });
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
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
              Stack(children: [
                (_image != null)
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://cdn-icons-png.freepik.com/512/1144/1144760.png")),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () async {
                          selectImage();
                        },
                        icon: const Icon(Icons.add_a_photo)))
              ]),
              const SizedBox(
                height: 25,
              ),
              TextFieldInput(
                controller: userName,
                hintText: "Enter Your Username",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFieldInput(
                controller: email,
                hintText: "Enter Your email",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFieldInput(
                controller: password,
                hintText: "Enter Your Password",
                isPass: true,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFieldInput(
                controller: bio,
                hintText: "Enter Your bio",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                  width: double.infinity,
                  height: 56,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the radius as needed
                        ),
                      ),
                      onPressed: () async {
                        sinUpUser();
                      },
                      child: isloading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Sign up"))),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Having an Account?"),
                  TextButton(
                    onPressed: () {
                      navigateToLogin();
                    },
                    child: const Text("Log in"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
