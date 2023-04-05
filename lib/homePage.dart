// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:app001/Service/UserService.dart';
import 'package:app001/uploadStatusScreen.dart';
import 'package:app001/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/User.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Color background = Color(0xff17181C);
  Future<User> getUser = UserService.getUser(id: '905');
  Future<List<User>> getUsers = UserService.getAllUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: CustomAppBar(
        height: 56,
        image: 'assets/001.png',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getUser = UserService.getUser(id: '906');
            });
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                //stories
                SizedBox(
                  height: 95,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StatusUpload()));
                        },
                        child: Avatars(
                          userImage: 'assets/man.png',
                        ),
                      ),
                      Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('status')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasData &&
                                    snapshot.data!.docs.isNotEmpty) {
                                  final data = snapshot.data as QuerySnapshot;
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: data.docs.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StatusViewer(
                                                            url:
                                                                data.docs[index]
                                                                    ['url'])));
                                          },
                                          child: StoryAvatar(
                                              userName: data.docs[index]
                                                      ['name'] ??
                                                  'Unknown',
                                              userimage: data.docs[index]
                                                  ['url']),
                                        );
                                      });
                                }
                                return Center(
                                    child: CustomText(
                                        'Sorry No Posts', 20, Colors.white));
                              })),
                    ],
                  ),
                ),
                //
                //feed
                Divider(
                  thickness: 0.3,
                  color: Colors.grey,
                ),

                FutureBuilder<List<User>>(
                    future: getUsers,
                    builder: ((context, snapshot) {
                      List<User>? users = snapshot.data;

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text(
                          snapshot.error.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      }
                      // if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: users!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: MemoryImage(base64Decode(
                                        users[index].image.toString())),
                                  ),
                                  title: Text(
                                    users[index].name.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    users[index].email.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: Text(
                                    users[index].id.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.3,
                                  color: Colors.grey,
                                ),
                              ],
                            );
                          });
                      // }
                      // return Center(
                      //     child:
                      //         CustomText('Sorry No Posts', 20, Colors.white));
                    })),
                // StreamBuilder<QuerySnapshot>(
                //     stream: FirebaseFirestore.instance
                //         .collection('posts')
                //         .orderBy('time', descending: true)
                //         .snapshots(),
                //     builder: (BuildContext context, snapshot) {
                //       if (snapshot.hasError) {
                //         return Text('Something went wrong');
                //       }
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                //         final data = snapshot.data as QuerySnapshot;
                //         return ListView.builder(
                //             physics: NeverScrollableScrollPhysics(),
                //             shrinkWrap: true,
                //             itemCount: data.docs.length,
                //             itemBuilder: (context, index) {
                //               DateTime now = DateTime.now();
                //               DateTime created = DateTime.parse(
                //                   data.docs[index]['time'].toString());
                //               Duration difference = now.difference(created);
                //               String timeLapsed;
                //               if (difference.inMinutes > 59) {
                //                 timeLapsed = difference.inHours.toString() + ' h';
                //               }
                //               if (difference.inHours > 23) {
                //                 timeLapsed = difference.inDays.toString() + ' d';
                //               } else {
                //                 timeLapsed =
                //                     difference.inMinutes.toString() + ' m';
                //               }
                //               return Post(
                //                 postedBy: data.docs[index]['postBy'],
                //                 title: data.docs[index]['title'],
                //                 postImage: data.docs[index]['images'],
                //                 descTop: data.docs[index]['desc'],
                //                 timeLapsed: timeLapsed,
                //                 userImage: data.docs[index]['userImage'],
                //                 likes: data.docs[index]['likes'].toString(),
                //                 comments: data.docs[index]['comments'],
                //                 latestComment: data.docs[index]['latestComment'],
                //                 commentsNumber:
                //                     data.docs[index]['commentsNumber'].toString(),
                //                 username: data.docs[index]['postBy'] ?? '',
                //               );
                //             });
                //       }
                //       return Center(
                //           child: CustomText('Sorry No Posts', 20, Colors.white));
                //     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
