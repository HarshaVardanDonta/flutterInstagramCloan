// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app001/widget.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Color background = Color(0xff17181C);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              //stories
              SizedBox(
                height: 95,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Center(
                      child: Avatars(
                        userImage: 'assets/man.png',
                      ),
                    ),
                    StoryAvatar(
                      userName: 'jlo',
                      userimage: 'assets/jlo.jpg',
                    ),
                    StoryAvatar(
                      userName: 'jennyrubyjane',
                      userimage: 'assets/jenny.jpg',
                    ),
                    StoryAvatar(
                      userName: 'inna',
                      userimage: 'assets/inna.jpg',
                    ),
                    StoryAvatar(
                        userName: 'Drake', userimage: 'assets/drake.jpg'),
                    StoryAvatar(
                        userName: 'beyonce', userimage: 'assets/beyonce.jpg')
                  ],
                ),
              ),
              //feed
              Divider(
                thickness: 0.3,
                color: Colors.grey,
              ),
              Post(
                descTop: 'Dubai',
                userImage: 'assets/jlo.jpg',
                username: 'jlo',
                likes: '50,120 likes',
                comment: 'Hi 😘',
                commentsNumber: '1,000',
                timeLapsed: '1 hr',
                postImage: 'assets/jloPost.jpg',
              ),
              Post(
                descTop: 'Siau Ibiza Hotel',
                timeLapsed: '2 hr',
                userImage: 'assets/inna.jpg',
                likes: '40,421',
                comment: 'in Ibiza 😘',
                commentsNumber: '391',
                username: 'inna',
                postImage: 'assets/innaPost.jpg',
              ),
              Post(
                  postImage: 'assets/jennyPost.jpg',
                  descTop: 'Korea',
                  timeLapsed: '4 hr',
                  userImage: 'assets/jenny.jpg',
                  likes: '5,235',
                  comment: '😘😘',
                  commentsNumber: '548',
                  username: 'jennyrubyjane'),
              Post(
                  postImage: 'assets/drakePost.jpg',
                  descTop: '',
                  timeLapsed: '3 hr',
                  userImage: 'assets/drake.jpg',
                  likes: '6,414',
                  comment: '11 years ago today. Drake released Marvins Room.',
                  commentsNumber: '486',
                  username: 'Drake'),
              Post(
                  postImage: 'assets/beyoncePost.jpg',
                  descTop: 'British Vogue July 2022',
                  timeLapsed: '6 hr',
                  userImage: 'assets/beyonce.jpg',
                  likes: '530,879',
                  comment: '',
                  commentsNumber: '1,568',
                  username: 'beyonce'),
            ],
          ),
        ),
      ),
    );
  }
}
