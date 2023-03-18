import 'package:app001/widget.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomText('Add Post', 20, Colors.white),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: CustomText('Add image', 20, Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            hint: "title",
            controller: titleController,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            hint: "Description",
            controller: descController,
          ),
        ],
      ),
    )));
  }
}
