import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireHome {
  static QuerySnapshot<Map<String, dynamic>>? myData;
  static Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    try {
      await FireService.store
          .collection('chats')
          .doc(FireService.auth.currentUser!.email).collection('${FireService.auth.currentUser!.email}')
          .get()
          .then((value) {
        myData = value;
        // print(myData['name'].toString());
      });
      return myData!;
    } catch (e) {
      return myData!;
    }
  }


}
