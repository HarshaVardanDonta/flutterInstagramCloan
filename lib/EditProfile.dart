import 'dart:io';

import 'package:app001/Service/UserService.dart';
import 'package:app001/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            CustomTextField(hint: 'username', controller: user),
            ElevatedButton(
                onPressed: () async {
                  ImagePicker _imagePicker = ImagePicker();
                  XFile? image = await _imagePicker.pickImage(
                      source: ImageSource.gallery, imageQuality: 50);
                  final bytes = await image!.readAsBytes();
                  final file = File(image.path);

                  await UserService.updateUser(
                      id: 906,
                      image: file,
                      name: user.text,
                      email: 'email.com');
                },
                child: CustomText('change profile pic', 20, Colors.white))
          ]),
        ),
      ),
    );
  }
}
