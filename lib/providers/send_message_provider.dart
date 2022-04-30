import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SendMessageProvider extends ChangeNotifier{
    List<String> usersList = [];
  List sortList = [];
  List messageList = [];

  Future bindUsers(String secondEmail, ) async{
    try {
      await FireService.store.collection('chats').get().then((value){
        sortList.clear();
      for (var i = 0; i < value.docs.length; i++) {
        usersList.add(value.docs[i].id.toString());
        if (secondEmail == value.docs[i].id) {
          sortList.add("${FireService.auth.currentUser!.email}");
          sortList.add("${value.docs[i].id}");
          sortList.sort();
          print(sortList);
        }
      }
    });
    } catch (e) {
      print("error");
    }
    notifyListeners();
  }

  Future createField()async{
    try {
      await FireService.store.collection('messages').doc("${sortList.first}${sortList.last}").collection('coll').doc("${sortList.first}${sortList.last}").set({
          "messageList": []
      });
      SetOptions(merge: true);
      notifyListeners();
    } catch (e) {
    }
  }

  Future sendMessage(String from, String message)async{

            messageList.add({
            "from": from,
            "sent_at": DateTime.now(),
            "message": message,
          });

    try {
      await FireService.store.collection('messages').doc("${sortList.first}${sortList.last}").collection('coll').doc("${sortList.first}${sortList.last}").set({
          "messageList": messageList,
      });SetOptions(merge: true);
      notifyListeners();
    } catch (e) {
      print(e);
    }

    notifyListeners();

  }

  Future updateList()async{
    try {
      await FireService.store.collection('messages').doc("${sortList.first}${sortList.last}").get().then((value){
        messageList = value.data()!['messageList'];
        print(messageList);
      });
    } catch (e) {
      print(e);
    }
  }

}