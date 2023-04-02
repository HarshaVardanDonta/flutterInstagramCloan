// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, non_constant_identifier_names, camel_case_types

import 'dart:io';

import 'package:app001/AddPost.dart';
import 'package:app001/ViewAllComments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'homePage.dart';
import 'main02.dart';

Color post = Color.fromARGB(255, 36, 36, 36);
Color bar = Color.fromARGB(255, 12, 13, 16);

Text CustomText(String x, double size, Color color) {
  return Text(
    x,
    overflow: TextOverflow.ellipsis,
    style:
        GoogleFonts.poppins(textStyle: TextStyle(color: color, fontSize: size)),
  );
}

//

class CustomTextField extends StatefulWidget {
  String hint;
  TextEditingController controller;
  bool? isObscure;

  CustomTextField(
      {Key? key, required this.hint, required this.controller, this.isObscure})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObscure ?? false,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

//

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  double height;
  String image;

  CustomAppBar({Key? key, required this.height, required this.image})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => CustomAappBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class CustomAappBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: bar,
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 120,
            child: Image.asset(widget.image),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPost()));
                },
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Icon(
                        FontAwesomeIcons.facebookMessenger,
                        size: 22,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      '5',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class Avatars extends StatefulWidget {
  String userImage;

  Avatars({Key? key, required this.userImage}) : super(key: key);

  @override
  State<Avatars> createState() => AavatarsState();
}

class AavatarsState extends State<Avatars> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Stack(alignment: Alignment.bottomRight, children: [
            CircleAvatar(
              radius: 33,
              backgroundImage: AssetImage(widget.userImage),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ]),
        ),
        SizedBox(height: 10),
        CustomText("your story", 11, Colors.white),
      ],
    );
  }
}

class StoryAvatar extends StatefulWidget {
  String userName;
  String userimage;

  StoryAvatar({Key? key, required this.userName, required this.userimage})
      : super(key: key);

  @override
  State<StoryAvatar> createState() => _StoryAvatarState();
}

class _StoryAvatarState extends State<StoryAvatar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 77,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
            child: CircleAvatar(
              radius: 33,
              backgroundImage: AssetImage('assets/gradient.webp'),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.userimage),
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomText(widget.userName, 11, Colors.white),
        ],
      ),
    );
  }
}

class Post extends StatefulWidget {
  String username;
  String title;
  String userImage;
  String descTop;
  String likes;
  String latestComment;
  String timeLapsed;
  List<dynamic> postImage;
  List comments;
  String commentsNumber;
  String postedBy;

  Post(
      {Key? key,
      required this.postImage,
      required this.title,
      required this.descTop,
      required this.timeLapsed,
      required this.userImage,
      required this.likes,
      required this.latestComment,
      required this.comments,
      required this.commentsNumber,
      required this.username,
      required this.postedBy})
      : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  PageController _pageController = PageController(
    initialPage: 0,
  );
  bool userAlreadyLiked = false;
  bool expandComments = false;
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocus = FocusNode();
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: post,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          widget.userImage,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(widget.username, 13, Colors.white),
                        CustomText(widget.descTop, 11, Colors.white)
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.white,
              )
            ],
          ),
          SizedBox(height: 10),
          //image or video
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: widget.postImage.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.postImage[index].toString(),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: SmoothPageIndicator(
                controller: _pageController,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.white,
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 4,
                    spacing: 4),
                count: widget.postImage.length),
          ),
          SizedBox(height: 10),
          //like
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          splashColor: Colors.white,
                          onTap: () async {
                            CollectionReference _collectionRef =
                                FirebaseFirestore.instance.collection('posts');
                            QuerySnapshot querySnapshot =
                                await _collectionRef.get();
                            for (int i = 0;
                                i < querySnapshot.docs.length;
                                i++) {
                              if (querySnapshot.docs[i]['title'] ==
                                  "${widget.title}") {
                                if (!querySnapshot.docs[i]['likedBy'].contains(
                                    FirebaseAuth
                                        .instance.currentUser!.displayName)) {
                                  await FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(widget.title)
                                      .update({
                                    'likes': '${int.parse(widget.likes) + 1}',
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(widget.title)
                                      .update({
                                    'likedBy': FieldValue.arrayUnion([
                                      FirebaseAuth
                                          .instance.currentUser!.displayName
                                    ])
                                  });
                                  setState(() {
                                    userAlreadyLiked = true;
                                  });
                                  print("found");
                                }
                              }
                            }
                          },
                          child: Icon(
                            FontAwesomeIcons.heart,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        CustomText(widget.likes, 13, Colors.white),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              expandComments = !expandComments;
                              commentFocus.requestFocus();
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.comment,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        CustomText(widget.commentsNumber, 13, Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                FontAwesomeIcons.bookmark,
                color: Colors.white,
              )
            ],
          ),
          if (expandComments)
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                          focusNode: commentFocus,
                          controller: commentController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ))),
                  Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () async {
                          if (commentController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Comment can't be empty")));
                          } else {
                            commentFocus.unfocus();
                            await FirebaseFirestore.instance
                                .collection('posts')
                                .doc(widget.title)
                                .update({
                              'latestComment':
                                  "${user!.displayName}:${commentController.text}",
                              'commentsNumber':
                                  '${int.parse(widget.commentsNumber) + 1}',
                              'comments': FieldValue.arrayUnion([
                                '${user!.displayName}:${commentController.text}'
                              ])
                            });
                            commentController.clear();
                            commentFocus.unfocus();
                            setState(() {
                              expandComments = false;
                            });
                          }
                        },
                        icon: Icon(Icons.send),
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          SizedBox(height: 10),
          CustomText('${widget.title}', 19, Colors.white),
          //comments
          if (widget.comments.length != 0) SizedBox(height: 8),
          if (widget.comments.length != 0)
            Row(
              children: [
                // Builder(builder: (context) {
                //   int index = 0;
                //   QuerySnapshot querySnapshot;
                //   getData() async {
                //     CollectionReference _collectionRef =
                //         FirebaseFirestore.instance.collection('users');
                //     querySnapshot = await _collectionRef.get();
                //     for (int i = 0; i < querySnapshot.docs.length; i++) {
                //       if (querySnapshot.docs[i]['displayName'] ==
                //           "${widget.latestComment.split(':')[0]}") {
                //         setState(() {
                //           index = i;
                //         });
                //       }
                //     }
                //   }
                //
                //   getData();
                //   return CircleAvatar(
                //     radius: 15,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(50),
                //       child: Image.network(
                //         querySnapshot.docs[index]['photoURL'],
                //         loadingBuilder: (context, child, loadingProgress) {
                //           if (loadingProgress == null) return child;
                //           return Container(
                //             height: 40,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //                 color: Colors.black,
                //                 borderRadius: BorderRadius.circular(10)),
                //             child: Center(
                //               child: CircularProgressIndicator(
                //                 color: Colors.white,
                //               ),
                //             ),
                //           );
                //         },
                //         errorBuilder: (context, error, stackTrace) {
                //           return Container(
                //             height: 40,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //                 color: Colors.black,
                //                 borderRadius: BorderRadius.circular(10)),
                //             child: Center(
                //               child: Icon(
                //                 Icons.error,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           );
                //         },
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   );
                // }),
                // SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: CustomText('${widget.latestComment.split(':')[1]}',
                          13, Colors.white),
                    ),
                    CustomText('by ${widget.latestComment.split(':')[0]}', 9,
                        Colors.grey)
                  ],
                ),
              ],
            ),
          if (widget.comments.length != 0) SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ViewAllComments(comments: widget.comments)));
            },
            child: CustomText('View all ' + widget.commentsNumber + ' comments',
                13, Colors.grey),
          ),
          SizedBox(height: 8),
          CustomText(widget.timeLapsed + ' ago', 13, Colors.grey),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class Reel extends StatefulWidget {
  String url;
  String userImage;
  String desc;
  String username;
  String likes;
  String location;
  String commentsNumber;
  String song;

  Reel(
      {Key? key,
      required this.url,
      required this.location,
      required this.song,
      required this.commentsNumber,
      required this.likes,
      required this.desc,
      required this.userImage,
      required this.username})
      : super(key: key);

  @override
  State<Reel> createState() => _ReelState();
}

class _ReelState extends State<Reel> {
  // ignore: unused_field

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).viewInsets.bottom -
            10 -
            MediaQuery.of(context).padding.bottom -
            kToolbarHeight -
            kBottomNavigationBarHeight,
        // MediaQuery.of(context).padding.top,
      ),
      Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.heart, color: Colors.white),
                    CustomText(widget.likes, 15, Colors.white)
                  ],
                )),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.comment, color: Colors.white),
                    CustomText(widget.commentsNumber, 15, Colors.white)
                  ],
                )),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.paperPlane, color: Colors.white),
                    CustomText(widget.likes, 15, Colors.white)
                  ],
                )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.userImage),
                      ),
                      SizedBox(width: 10),
                      CustomText(widget.username, 15, Colors.white),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.white24, width: 2)),
                        child: CustomText('Follow', 15, Colors.white),
                      ),
                    ],
                  ),
                ),
                Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomText(widget.desc, 15, Colors.white)),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Marquee(
                    text: widget.song,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 5.0,
                    velocity: 50.0,
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 0.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                CustomText(widget.location, 15, Colors.white)
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      )
    ]);
  }
}

class searchWidget extends StatefulWidget {
  int cross;
  int main;

  String image;

  searchWidget(
      {Key? key, required this.cross, required this.image, required this.main})
      : super(key: key);

  @override
  State<searchWidget> createState() => _searchWidgetState();
}

class _searchWidgetState extends State<searchWidget> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: widget.cross,
      mainAxisCellCount: widget.main,
      child: Container(
        decoration: BoxDecoration(),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}

class ActivityAvatar extends StatefulWidget {
  String userImage;
  String userName;
  Widget wid;
  Widget ending;

  ActivityAvatar(
      {Key? key,
      required this.ending,
      required this.userImage,
      required this.userName,
      required this.wid})
      : super(key: key);

  @override
  State<ActivityAvatar> createState() => _ActivityAvatarState();
}

class _ActivityAvatarState extends State<ActivityAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(widget.userImage),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(widget.userName, 15, Colors.white),
                  widget.wid,
                ],
              ),
            ]),
          ),
          widget.ending,
        ],
      ),
    );
  }
}

class ProfileAppBar extends StatefulWidget implements PreferredSizeWidget {
  double height;

  ProfileAppBar({Key? key, required this.height}) : super(key: key);

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      height: 65,
      decoration:
          BoxDecoration(color: post, borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          child: Row(
            children: [
              CustomText('User._.name', 18, Colors.white),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              Icon(
                Icons.add_box_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

class ImageViewer extends StatefulWidget {
  List<File> images;

  ImageViewer({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      itemCount: widget.images.length,
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: Image.file(widget.images[index]).image,
        );
      },
    );
  }
}

class StatusViewer extends StatefulWidget {
  String url;

  StatusViewer({Key? key, required this.url}) : super(key: key);

  @override
  State<StatusViewer> createState() => _StatusViewerState();
}

class _StatusViewerState extends State<StatusViewer>
    with TickerProviderStateMixin {
  // late AnimationController controller;

  @override
  void initState() {
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )..addListener(() {
    //     setState(() {});
    //   });
    // controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.01,
            //   child: LinearProgressIndicator(
            //     backgroundColor: Colors.black,
            //     color: Colors.white,
            //     value: controller.value,
            //   ),
            // ),

            Expanded(
              child: Container(
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
