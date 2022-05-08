import 'dart:io';

import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WriteService {
  String? ids;
  Future signUp(String emailController, String passwordController) async {
    try {
      await FireService.auth.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );

      await FireService.auth.currentUser!.sendEmailVerification();
    } catch (e) {
      print("Error");
    }
  }

  Future saveToStore() async {
    try {
      await FireService.store
          .collection('chats')
          .doc("${FireService.auth.currentUser!.email.toString()}")
          .set({});
    } catch (e) {
      print("error");
    }
  }



  Future fillProfile(BuildContext context, XFile file, String firstname,
      String lastname) async {
    try {
      var image = await FireService.storage
          .ref()
          .child('users')
          .child('avatars')
          .child(FireService.auth.currentUser!.email.toString())
          .putFile(File(file.path));

      String downloadUrl = await image.ref.getDownloadURL();

      await FireService.store
          .collection('chats')
          .doc('${FireService.auth.currentUser!.email}')
          .update(
        {
          "avatar_image_url": downloadUrl,
          "firstname": firstname,
          "lastname": lastname,
          "created_at": FieldValue.serverTimestamp(),
        },
      );
    } catch (e) {
      print("Error while updating!");
    }
  }


  Future signIn(BuildContext context, String emailController,
      String passwordController) async {
    try {
      await FireService.auth.signInWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
        // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       print(e);
      } else if (e.code == 'wrong-password') {
        print(e);

      }
    }

  }
}
