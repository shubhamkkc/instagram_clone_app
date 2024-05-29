import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone_app/screen/profile_screen.dart';
import 'package:instagram_clone_app/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isUserAvailable = false;
  TextEditingController _search = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: _search,
            onFieldSubmitted: (String _) {
              setState(() {
                isUserAvailable = true;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "search for a user",
            ),
          ),
        ),
        body: isUserAvailable
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isGreaterThanOrEqualTo: _search.text)
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen())),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data!.docs[index]["file"]),
                            ),
                            title: Text(snapshot.data!.docs[index]["username"]),
                          ),
                        );
                      });
                })
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: snapshot.data!.docs
                          .asMap()
                          .entries
                          .map(
                            (entry) => StaggeredGridTile.count(
                              crossAxisCellCount: (entry.key % 7 == 0) ? 2 : 1,
                              mainAxisCellCount: (entry.key % 7 == 0) ? 2 : 1,
                              child: Image.network(entry.value["postImageUrl"]),
                            ),
                          )
                          .toList());
                  // [

                  //   StaggeredGridTile.count(
                  //     crossAxisCellCount: 2,
                  //     mainAxisCellCount: 2,
                  //     child: Container(
                  //       color: Colors.amberAccent,
                  //     ),
                  //   ),

                  //   StaggeredGridTile.count(
                  //     crossAxisCellCount: 1,
                  //     mainAxisCellCount: 1,
                  //     child: Container(
                  //       color: Colors.cyanAccent,
                  //     ),
                  //   ),
                  //   StaggeredGridTile.count(
                  //     crossAxisCellCount: 1,
                  //     mainAxisCellCount: 1,
                  //     child: Container(),
                  //   ),
                  //   StaggeredGridTile.count(
                  //     crossAxisCellCount: 4,
                  //     mainAxisCellCount: 2,
                  //     child: Container(
                  //       color: Colors.greenAccent,
                  //     ),
                  //   ),
                  //   StaggeredGridTile.count(
                  //     crossAxisCellCount: 4,
                  //     mainAxisCellCount: 2,
                  //     child: Container(
                  //       color: Colors.greenAccent,
                  //     ),
                  //   ),
                  //   StaggeredGridTile.count(
                  //     crossAxisCellCount: 4,
                  //     mainAxisCellCount: 2,
                  //     child: Container(
                  //       color: Colors.greenAccent,
                  //     ),
                  //   ),
                  // ],
                  // );
                }),
      ),
    );
  }
}
