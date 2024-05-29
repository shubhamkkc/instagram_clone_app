import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/models/user.dart';
import 'package:instagram_clone_app/provider/user_provider.dart';
import 'package:instagram_clone_app/resourcre/fireStore_method.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:instagram_clone_app/utils/utils.dart';
import 'package:instagram_clone_app/widgets/comment.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final Map<String, dynamic> postDetail;
  const PostWidget({super.key, required this.postDetail});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isPostLike = false;
  void _showComments(
      BuildContext context, User user, Map<String, dynamic> postDetail) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: CommentUi(
          user: user,
          postDetail: postDetail,
        ),
      ),
    );
  }

  int countOfComments = 0;
  void getComment() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postDetail['postId'])
          .collection('comment')
          .get();

      countOfComments = snap.docs.length;
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    getComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List likes = widget.postDetail["like"];
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.postDetail["profileImage"]),
                ),
              ),
              Text(widget.postDetail["userName"]),
              Spacer(),
              IconButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        surfaceTintColor: mobileBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  FireStoreMethod()
                                      .deletePost(widget.postDetail['postId']);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.more_vert))
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                widget.postDetail["postImageUrl"],
                fit: BoxFit.cover,
              )),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await FireStoreMethod()
                        .likePost(user.uid, widget.postDetail["postId"], likes);

                    if (!likes.contains(user.uid)) {
                      setState(() {
                        isPostLike = true;
                      });
                    } else {
                      setState(() {
                        isPostLike = false;
                      });
                    }
                  },
                  icon: isPostLike
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () =>
                      _showComments(context, user, widget.postDetail),
                  icon: Icon(Icons.comment)),
              IconButton(onPressed: () {}, icon: Icon(Icons.send)),
              Spacer(),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.bookmark_outline_sharp))
            ],
          ),
          Text("${widget.postDetail["like"].length} likes"),
          Text(
              "${widget.postDetail["userName"]}  ${widget.postDetail["caption"]}"),
          Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "view all $countOfComments comments",
                style: TextStyle(color: secondaryColor),
              )),
        ],
      ),
    );
  }
}
