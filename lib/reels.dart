// ignore_for_file: prefer_const_constructors

import 'package:app001/widget.dart';
import 'package:flutter/material.dart';

class Reels extends StatefulWidget {
  const Reels({Key? key}) : super(key: key);

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: PageScrollPhysics(),
          children: [
            Reel(
                url: 'url',
                location: 'India',
                song: 'song dasadfafasdfsdfgsdfgsfgedesdgf',
                commentsNumber: '100',
                likes: '200',
                desc: 'description',
                userImage: 'assets/jlo.jpg',
                username: 'jlo'),
            Reel(
                url: 'url',
                location: 'India',
                song: 'song dasadfafasdfsdfgsdfgsfgedesdgf',
                commentsNumber: '100',
                likes: '200',
                desc: 'description',
                userImage: 'assets/jenny.jpg',
                username: 'jlo'),
          ],
        ),
      ),
    );
  }
}
