import 'package:app001/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllComments extends StatefulWidget {
  List comments;

  ViewAllComments({Key? key, required this.comments}) : super(key: key);

  @override
  State<ViewAllComments> createState() => _ViewAllCommentsState();
}

class _ViewAllCommentsState extends State<ViewAllComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView.builder(
        reverse: true,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(widget.comments[index].toString().split(':')[0],
                      20, Colors.grey),
                ],
              ),
              subtitle: CustomText(
                  widget.comments[index].toString().split(':')[1],
                  15,
                  Colors.white));
        },
      ),
    ));
  }
}
