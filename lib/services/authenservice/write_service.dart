import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteService{

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
      await FireService.store.collection('chats').doc("${FireService.auth.currentUser!.email.toString()}").set({});
    } catch (e) {
      print("error");
    }
  }


}