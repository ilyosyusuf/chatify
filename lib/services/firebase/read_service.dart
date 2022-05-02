import 'package:chatify/services/firebase/fire_service.dart';

class FireHome {
  static Map<String, dynamic> myData = {};
  static Future<Map<String, dynamic>> getData() async {
    try {
      await FireService.store
          .collection('chats')
          .doc(FireService.auth.currentUser!.email)
          .get()
          .then((value) {
        myData = value.data()!;
        print(myData['name'].toString());
      });
      return myData;
    } catch (e) {
      return myData;
    }
  }


}
