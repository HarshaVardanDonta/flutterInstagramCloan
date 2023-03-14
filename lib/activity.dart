// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:app001/widget.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff17181C);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText('Yesterday', 18, Colors.white),
              ActivityAvatar(
                userImage: 'assets/man.png',
                userName: 'user liked youur comment',
                wid: CustomText('🔥🔥', 15, Colors.black),
                ending: SizedBox(
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/jennyPost.jpg'))),
              ),
              CustomText('This Week', 18, Colors.white),
              ActivityAvatar(
                  ending: CustomText('2d ago', 15, Colors.grey),
                  userImage: 'assets/drake.jpg',
                  userName: 'drake',
                  wid: CustomText('started following you', 15, Colors.white)),
              ActivityAvatar(
                  ending: Container(
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomText('Follow', 15, Colors.white),
                  ),
                  userImage: 'assets/beyonce.jpg',
                  userName: 'beyonce who you ',
                  wid: CustomText(
                      'might know is on instagram', 15, Colors.white)),
              CustomText('This Month', 18, Colors.white),
              ActivityAvatar(
                  ending: Container(
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomText('Follow', 15, Colors.white),
                  ),
                  userImage: 'assets/jenny.jpg',
                  userName: 'jenny who you',
                  wid: CustomText(
                      'might know is on instagram', 15, Colors.white)),
              ActivityAvatar(
                  ending: Container(
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomText('Follow', 15, Colors.white),
                  ),
                  userImage: 'assets/inna.jpg',
                  userName: 'inna who you',
                  wid: CustomText(
                      'might know is on instagram', 15, Colors.white)),
              CustomText('Earlier', 18, Colors.white),
              ActivityAvatar(
                  ending: Container(
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomText('Follow', 15, Colors.white),
                  ),
                  userImage: 'assets/jlo.jpg',
                  userName: 'jlo who you',
                  wid: CustomText(
                      'might know is on instagram', 15, Colors.white)),
              ActivityAvatar(
                userImage: 'assets/man.png',
                userName: 'User and other user',
                wid: CustomText('liked your Story', 15, Colors.white),
                ending: SizedBox(
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/jloPost.jpg'))),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
