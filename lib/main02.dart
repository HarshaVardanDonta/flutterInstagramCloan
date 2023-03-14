// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unused_element

import 'package:app001/activity.dart';
import 'package:app001/homePage.dart';
import 'package:app001/profile.dart';
import 'package:app001/reels.dart';
import 'package:app001/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Main02 extends StatefulWidget {
  const Main02({Key? key}) : super(key: key);

  @override
  State<Main02> createState() => _Main02State();
}

class _Main02State extends State<Main02> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    homePage(),
    Search(),
    Reels(),
    Activity(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff17181C);
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: background,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_collection_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.heart,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: ''),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
