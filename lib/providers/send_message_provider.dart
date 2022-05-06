import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SendMessageProvider extends ChangeNotifier {
  SendMessageProvider() {
    fillList();
    updateList();
  }
  List<String> usersList = [];
  List sortList = [];
  List messageList = [];
  List diaList = [];
  Future bindUsers(
    String secondEmail,
  ) async {
    try {
      await FireService.store.collection('chats').get().then((value) {
        sortList.clear();
        for (var i = 0; i < value.docs.length; i++) {
          usersList.add(value.docs[i].id.toString());
          if (secondEmail == value.docs[i].id) {
            sortList.add("${FireService.auth.currentUser!.email}");
            sortList.add("${value.docs[i].id}");
            sortList.sort();
            diaList.add(value.docs[i].id);
            if(value.docs[i].id != FireService.store
                .collection('chats')
                .doc("${FireService.auth.currentUser!.email}")
                .collection("${FireService.auth.currentUser!.email}")
                .doc("${value.docs[i].id}")){

              FireService.store
                .collection('chats')
                .doc("${FireService.auth.currentUser!.email}")
                .collection("${FireService.auth.currentUser!.email}")
                .doc("${value.docs[i].id}")
                .set({
              "avatar_image_url": value.docs[i]['avatar_image_url'],
              "firstname": value.docs[i]['firstname'],
              "lastname": value.docs[i]['lastname'],
              "created_at": value.docs[i]['created_at'],
            });
                }
            print(sortList);
          }
        }
      });
    } catch (e) {
      print("error");
    }
    notifyListeners();
  }

  Future dialogWith(
    String secondEmail,
  ) async {
    try {
      await FireService.store.collection('chats').get().then((value) {
        sortList.clear();
        for (var i = 0; i < value.docs.length; i++) {
          usersList.add(value.docs[i].id.toString());
          if (secondEmail == value.docs[i].id) {
            sortList.add("${FireService.auth.currentUser!.email}");
            sortList.add("${value.docs[i].id}");
            sortList.sort();
            diaList.add(value.docs[i].id);
            FireService.store
                .collection('chats')
                .doc("${FireService.auth.currentUser!.email}")
                .collection("${FireService.auth.currentUser!.email}")
                .doc("${value.docs[i].id}")
                .set({
              "avatar_image_url": value.docs[i]['avatar_image_url'],
              "firstname": value.docs[i]['firstname'],
              "lastname": value.docs[i]['lastname'],
              "created_at": value.docs[i]['created_at'],
            });

            FireService.store
                .collection('chats')
                .doc("${value.docs[i].id}")
                .collection("${value.docs[i].id}")
                .doc("${FireService.auth.currentUser!.email}")
                .set({
              "avatar_image_url": value.docs[i]['avatar_image_url'],
              "firstname": value.docs[i]['firstname'],
              "lastname": value.docs[i]['lastname'],
              "created_at": value.docs[i]['created_at'],
            });

            // print(sortList);
          }
        }
      });
    } catch (e) {
      print("error");
    }
    notifyListeners();
  }


  // Future dialogWith()async{
  //   // try {
  //   //   await FireService.store.collection('chats').doc("${FireService.auth.currentUser!.email}").update({
  //   //       "dialogWith": diaList
  //   //   });
  //   //   SetOptions(merge: true);
  //   //   notifyListeners();
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  //   try {
  //   } catch (e) {
  //     print('dialogWith $e');
  //   }
  // }

  // Future fillDial()async{
  //   try {
  //     await FireService.store.collection('chats').doc("${FireService.auth.currentUser!.email}").get().then((value){
  //       diaList = value.data()!['dialogWith'];
  //     });
  //     notifyListeners();
  //   } catch (e) {
  //     print('fillDial $e');
  //   }
  // }

  Future createColl() async {
    try {
      await FireService.store
          .collection('messages')
          .doc("${sortList.first}${sortList.last}")
          .collection('coll')
          .doc("${sortList.first}${sortList.last}")
          .set({});
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future createField() async {
    try {
      await FireService.store
          .collection('messages')
          .doc("${sortList.first}${sortList.last}")
          .collection('coll')
          .doc("${sortList.first}${sortList.last}")
          .get()
          .then((value) {
        if (value.data()!.isEmpty) {
          FireService.store
              .collection('messages')
              .doc("${sortList.first}${sortList.last}")
              .collection('coll')
              .doc("${sortList.first}${sortList.last}")
              .update({"messageList": []});
        }
      });

      SetOptions(merge: true);
      notifyListeners();
    } catch (e) {}
  }

  Future sendMessage(String from, String message) async {
    messageList.add({
      "from": from,
      "email_from": FireService.auth.currentUser!.email,
      "sent_at": DateTime.now(),
      "message": message,
    });

    try {
      await FireService.store
          .collection('messages')
          .doc("${sortList.first}${sortList.last}")
          .collection('coll')
          .doc("${sortList.first}${sortList.last}")
          .update({
        "messageList": messageList,
      });
      SetOptions(merge: true);
      notifyListeners();
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  String? last;

  Future updateList() async {
    try {
      await FireService.store
          .collection('messages')
          .doc("${sortList.first}${sortList.last}")
          .collection('coll')
          .doc("${sortList.first}${sortList.last}")
          .get()
          .then((value) {
        messageList = value.data()!['messageList'];
        last = value.data()!['messageList'].last['message'];
        print(messageList);
      });
    } catch (e) {
      print(e);
    }
  }

  // Future deleteDoc() async{
  //   try {
  //       await FireService.store
  //         .collection('messages')
  //         .doc("${sortList.first}${sortList.last}").delete();
  //         notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future loginWithOtp(String phoneController) async {
    await FireService.auth.verifyPhoneNumber(
      phoneNumber: phoneController,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FireService.auth.signInWithCredential(credential);
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> MyHomePage()), (route) => false);
        print("Excellent");
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // showSnackBar('The provided phone number is not valid', Colors.red);
          print('The provided phone number is not valid');
        } else {
          // showSnackBar('Another Error Type!', Colors.red);
          print('Another Error Type!');
        }
      },
      codeSent: (String verificationId, [int? resendToken]) async {
        String smsCode = '112233';

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        try {
          var firebaseUser =
              await FireService.auth.signInWithCredential(credential);
          print(firebaseUser.user);
        } catch (e) {
          print(e);
        }
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> MyHomePage()), (route) => false);
        // print("excellent");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    notifyListeners();
  }

  Set setList = {};
  List allData = [];
  Future fillList() async {
    await FireService.store.collection('chats').get().then((value) {
      for (var item in value.docs) {
        if (item.id == FireService.auth.currentUser!.email.toString()) {
          continue;
        } else {
          allData.add(item);
        }
        // print(allData);
      }
    });
  }

  Future searchIt(String text) async {
    setList.clear();
    for (var i = 0; i < allData.length; i++) {
      // print(allData[i]);
      if (text.isEmpty) {
        setList.clear();
        notifyListeners();
      } else if (allData[i]
          .id
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) {
        setList.add(allData[i]);
        print(setList.toList());
      }
    }
  }
}
