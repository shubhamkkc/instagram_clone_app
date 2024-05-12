import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/models/user.dart';
import 'package:instagram_clone_app/provider/user_provider.dart';
import 'package:instagram_clone_app/resourcre/post_mothod.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:instagram_clone_app/utils/liner_loader.dart';
import 'package:instagram_clone_app/utils/utils.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Uint8List? _file;
  final TextEditingController _caption = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _caption.dispose();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create a Post"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text("Take a Photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text("Take a from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text("Cancel"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void uploadPost(String uId) async {
    setState(() {
      isLoading = true;
    });
    if (_file != null) {
      String res = await PostMethod()
          .postUpload(uid: uId, caption: _caption.text, postImage: _file!);
      print(res);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () {
                  _selectImage(context);
                },
                icon: Icon(Icons.upload_file)))
        : SafeArea(
            child: Scaffold(
              // backgroundColor: mobileBackgroundColor,
              appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                title: Text("Post To"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () async {
                        print(_caption.text);
                        uploadPost(user.uid);
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              body: Column(
                children: [
                  isLoading ? LinearLoader() : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(user!.photoUrl)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            controller: _caption,
                            maxLines: 8,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Write a caption..",
                            ),
                          )),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // body: Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         CircleAvatar(
              //           backgroundImage: NetworkImage(
              //               "https://media.istockphoto.com/id/1148091793/photo/technology-abstract.jpg?s=1024x1024&w=is&k=20&c=Q-tH-8QI959LcamRa50iCKV9UHcoBcZwh0bEPkeEzNE="),
              //         ),
              //         // TextField(),
              //         // Image.network("src")
              //       ],
              //     ),
              //   ],
              // )
            ),
          );
  }
}
