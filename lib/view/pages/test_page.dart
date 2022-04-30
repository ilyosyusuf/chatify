import 'package:chatify/services/firebase/fire_service.dart';
import 'package:chatify/view/pages/secondpage.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({ Key? key }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${FireService.auth.currentUser!.emailVerified}'),),
      // body: Center(child: ElevatedButton(onPressed: (){
      //       FireService.auth.currentUser!.emailVerified ?
      //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage())): showDialog(context: context, builder: (context)=>Container());

      // }, child: Text("HomePage"))),
    );
  }
}