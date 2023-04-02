import 'package:app001/login.dart';
import 'package:app001/main02.dart';
import 'package:app001/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17181C),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText('Register', 20, Colors.white),
            SizedBox(
              height: 20,
            ),
            CustomTextField(hint: "email", controller: emailController),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "password",
              controller: passController,
              isObscure: true,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              hint: "confirm password",
              controller: pass2Controller,
              isObscure: true,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: CustomText('register', 20, Colors.white),
              onPressed: () async {
                if (passController.text == pass2Controller.text) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(10),
                      shape: StadiumBorder(),
                      content: Text("Register success."),
                    ));
                    await FirebaseAuth.instance.currentUser!.updateProfile(
                        photoURL: 'https://i.imgur.com/BoN9kdC.png',
                        displayName: emailController.text.split('@')[0]);
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(emailController.text.split('@')[0])
                        .set({
                      'email': emailController.text,
                      'password': passController.text,
                      'displayName': emailController.text.split('@')[0],
                      'photoURL': 'https://i.imgur.com/BoN9kdC.png',
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Main02()),
                        (route) => false);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        shape: StadiumBorder(),
                        content: Text("The password provided is too weak."),
                      ));
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        shape: StadiumBorder(),
                        content:
                            Text("The account already exists for that email."),
                      ));
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(10),
                    shape: StadiumBorder(),
                    content: Text("The password provided is not the same."),
                  ));
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText('Already have an account?', 20, Colors.white),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                  child: CustomText('Login', 20, Colors.blue),
                )
              ],
            )
          ],
        )),
      )),
    );
  }
}
