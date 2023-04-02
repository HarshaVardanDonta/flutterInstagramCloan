import 'dart:io';

import 'package:app001/widget.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StatusUpload extends StatefulWidget {
  const StatusUpload({Key? key}) : super(key: key);

  @override
  State<StatusUpload> createState() => _StatusUploadState();
}

class _StatusUploadState extends State<StatusUpload> {
  bool imageSelected = false;
  File images = File('');
  var user = FirebaseAuth.instance.currentUser;
  bool posting = false;

  late CameraController controller;
  late List<CameraDescription> _cameras;
  bool camInit = false;
  bool showCam = true;

  initCam() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    setState(() {
      camInit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!camInit) {
      initCam();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: showCam
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CameraPreview(controller))
                        : Image.file(
                            images,
                            fit: BoxFit.cover,
                          ),
                  ),
                  if (posting)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.camera, imageQuality: 50);
                        final img = File(image!.path);
                        setState(() {
                          imageSelected = true;
                          images = img;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      )),
                  if (imageSelected)
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          showCam = false;
                          posting = true;
                        });
                        String downUrl = '';
                        final storageRef = FirebaseStorage.instance.ref();
                        final filePath = storageRef.child('${user!.uid}');
                        final File img = File(images.path);
                        await filePath.putFile(img).then(
                          (value) async {
                            await value.ref.getDownloadURL().then((value) {
                              downUrl = value;
                            });
                          },
                        );
                        await FirebaseFirestore.instance
                            .collection('status')
                            .doc(user!.displayName)
                            .set({
                          'url': downUrl,
                          'time': DateTime.now(),
                          'name': user!.displayName,
                        });
                        setState(() {
                          posting = false;
                        });
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  if (imageSelected)
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            showCam = true;
                            imageSelected = false;
                            images.delete();
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
