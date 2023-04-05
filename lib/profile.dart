// ignore_for_file: prefer_const_constructors

import 'package:app001/EditProfile.dart';
import 'package:app001/login.dart';
import 'package:app001/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff17181C);
    Color post = Color.fromARGB(255, 36, 36, 36);
    return SafeArea(
      child: Scaffold(
        endDrawer: Container(
          padding: EdgeInsets.all(8),
          width: 200,
          decoration: BoxDecoration(
            color: background,
          ),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                  child: CustomText('Logout', 20, Colors.white))
            ],
          ),
        ),
        backgroundColor: background,
        appBar: ProfileAppBar(
          height: 65,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: post, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage('assets/man.png'),
                        ),
                        Column(
                          children: [
                            CustomText('19', 15, Colors.white),
                            CustomText('Posts', 15, Colors.white)
                          ],
                        ),
                        Column(
                          children: [
                            CustomText('244', 15, Colors.white),
                            CustomText('Followers', 15, Colors.white)
                          ],
                        ),
                        Column(
                          children: [
                            CustomText('400', 15, Colors.white),
                            CustomText('Following', 15, Colors.white)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText('Username', 15, Colors.white),
                    CustomText(
                        'Interesting bio Interesting bio Interesting bio Interesting bio ',
                        15,
                        Colors.white),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                              child: Center(
                                  child: CustomText(
                                      'Edit profile', 15, Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Icon(
                              Icons.person_add,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: post, borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  height: 100,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage('assets/jloPost.jpg'),
                        ),
                        SizedBox(height: 10),
                        CustomText('😊😊', 20, Colors.black)
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage('assets/jlo.jpg'),
                        ),
                        SizedBox(height: 10),
                        CustomText('Lorem', 15, Colors.white)
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage('assets/jenny.jpg'),
                        ),
                        SizedBox(height: 10),
                        CustomText('Lorem', 15, Colors.white)
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage('assets/drake.jpg'),
                        ),
                        SizedBox(height: 10),
                        CustomText('Lorem', 15, Colors.white)
                      ],
                    ),
                  ]),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: post, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                Icons.grid_view_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 1,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Icon(
                            Icons.play_arrow_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Icon(
                            Icons.account_circle_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    StaggeredGrid.count(
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                        crossAxisCount: 3,
                        children: [
                          searchWidget(
                              cross: 1, image: 'assets/jlo.jpg', main: 1),
                          searchWidget(
                              cross: 1, image: 'assets/drake.jpg', main: 1),
                          searchWidget(
                              cross: 1, image: 'assets/beyonce.jpg', main: 1),
                          searchWidget(
                              cross: 1, image: 'assets/jenny.jpg', main: 1),
                          searchWidget(
                              cross: 1, image: 'assets/innaPost.jpg', main: 1),
                          searchWidget(
                              cross: 1,
                              image: 'assets/beyoncePost.jpg',
                              main: 1),
                          searchWidget(
                              cross: 1, image: 'assets/jennyPost.jpg', main: 1),
                          searchWidget(
                              cross: 1, image: 'assets/jloPost.jpg', main: 1)
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
