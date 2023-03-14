// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app001/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
              children: [
                //search bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: StaggeredGrid.count(
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      crossAxisCount: 3,
                      children: [
                        searchWidget(
                            cross: 1, image: 'assets/inna.jpg', main: 2),
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
                            cross: 1, image: 'assets/beyoncePost.jpg', main: 1),
                        searchWidget(
                            cross: 1, image: 'assets/drakePost.jpg', main: 2),
                        searchWidget(
                            cross: 1, image: 'assets/jennyPost.jpg', main: 1),
                        searchWidget(
                            cross: 1, image: 'assets/jloPost.jpg', main: 1)
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
