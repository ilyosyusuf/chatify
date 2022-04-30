import 'package:chatify/providers/send_message_provider.dart';
import 'package:chatify/services/authenservice/write_service.dart';
import 'package:chatify/services/firebase/fire_service.dart';
import 'package:chatify/view/pages/secondpage.dart';
import 'package:chatify/view/pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _secondController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatify")),
      body: Container(
        child: Column(children: [
          TextFormField(
            controller: _controller,
          ),
          TextFormField(
            controller: _secondController,
          ),
          ElevatedButton(onPressed: () async{
            // await context.read<SendMessageProvider>().bindUsers(_secondController.text);
            // await context.read<SendMessageProvider>().createField();
            // await context.read<SendMessageProvider>().updateList();
            // await context.read<SendMessageProvider>().sendMessage("Ilyos", "Hello");
            // await WriteService().signUp(_secondController.text, '1234567');
            // : showDialog(context: context, builder: (context)=>Container());
            await context.read<SendMessageProvider>().loginWithOtp(_secondController.text);
            setState(() {
              
            });

          }, child: Text("Send")),
          // ElevatedButton(onPressed: (){
          //   if (FireService.auth.currentUser!.emailVerified == true) {
          //     Navigator.push(context, MaterialPageRoute(builder: ((context) => TestPage())));
          //   }
          //   setState(() {
              
          //   });
          // }, 
          // child: Text("Home")
          // )
        ],),
      ),
    );
  }
}