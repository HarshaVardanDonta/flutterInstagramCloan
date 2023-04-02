import 'dart:io';

import 'package:app001/widget.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;
  List<File> images = [];
  bool imageSelected = false;
  PageController imageController = PageController(initialPage: 0);
  bool posting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomText('Add Post', 25, Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hint: "Title",
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hint: "Description",
                    controller: descController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 50);
                      final img = File(image!.path);
                      if (!images.contains(img)) {
                        setState(() {
                          images.add(img);
                          imageSelected = true;
                        });
                      }
                      print(images);
                    },
                    child: CustomText('Add image', 20, Colors.black),
                  ),
                  SizedBox(height: 20),
                  if (imageSelected)
                    Column(
                      children: [
                        Container(
                          height: 400,
                          child: PageView.builder(
                              physics: BouncingScrollPhysics(),
                              controller: imageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ImageViewer(
                                        images: images,
                                      ),
                                    ));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 20),
                        SmoothPageIndicator(
                            effect: WormEffect(
                                dotColor: Colors.grey[800]!,
                                activeDotColor: Colors.purple,
                                dotHeight: 10,
                                dotWidth: 10),
                            controller: imageController,
                            count: images.length),
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          if (posting)
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText('Posting...', 20, Colors.white),
                    ],
                  ),
                ),
              ),
            ),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () async {
          setState(() {
            if (imageSelected) posting = true;
          });
          final storageRef = FirebaseStorage.instance.ref();
          List urls = [];
          if (titleController.text != '' && descController.text != '') {
            for (int i = 0; i < images.length; i++) {
              final filePath =
                  storageRef.child('${user!.uid}/${titleController.text}/$i');
              final File img = File(images[i].path);
              await filePath.putFile(img).then(
                (value) async {
                  // urls.add(value.ref.getDownloadURL);
                  await value.ref.getDownloadURL().then((value) {
                    // FirebaseFirestore.instance
                    //     .collection('posts')
                    //     .doc('${user!.uid}')
                    //     .collection('images')
                    //     .doc('$i')
                    //     .set({
                    //   'url': value,
                    // });
                    urls.add(value);
                  });
                },
              );
            }
            await FirebaseFirestore.instance
                .collection('posts')
                .doc('${titleController.text}')
                .set({
              'postBy': user!.displayName,
              'title': titleController.text,
              'desc': descController.text,
              'uid': user!.uid,
              'time': DateTime.now().toString(),
              'images': images.length,
              'likes': 0,
              'images': urls,
              'likedBy': [],
              'latestComment': '',
              'comments': [],
              'commentsNumber': "0",
              'userImage': user!.photoURL ?? '',
              'postId': '${user!.uid}${DateTime.now().toString()}'
            }, SetOptions(merge: true));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText('Post added', 20, Colors.white),
              ),
            );
            setState(() {
              posting = false;
            });
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText('Please fill all fields', 20, Colors.white),
              ),
            );
          }
        },
        label: Row(
          children: [
            Icon(Icons.add),
            SizedBox(
              width: 10,
            ),
            Text('Post'),
          ],
        ),
      ),
    );
  }
}
