import 'package:chatify/providers/send_message_provider.dart';
import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({ Key? key }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}


class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(object)
  }
  @override
  Widget build(BuildContext context) {
    String sort1 = context.watch<SendMessageProvider>().sortList.first;
    String sort2 = context.watch<SendMessageProvider>().sortList.last;
    List messageList = context.watch<SendMessageProvider>().messageList;
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("stream")),
      body: StreamBuilder<QuerySnapshot<Map>>(
        stream: FireService.store.collection('messages').doc('${sort1+sort2}').collection('coll').snapshots(),
        // stream: FireService.store.collection('/messages/a@gmail.comc@gmail.com/coll').snapshots(),
        // doc('${sort1+sort2}').collection('messageList').snapshots(),
        
        // collection('messages/${context.watch<SendMessageProvider>().sortList.first+context.watch<SendMessageProvider>().sortList.last}/messageList').snapshots(),
                // .orderBy("sent_at")
                // .snapshots(),
            builder: (context,  snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snap.hasError) {
                return const Center(
                  child: Text("ERROR"),
                );
              } else{
                var data = snap.data!.docs[0];
                // print("DAAATTTAAAA $data");
                // users.sort();
                print("${sort1+sort2}");
                // print(data[0]['from']);
                // print(snap.data!.docs[0]);
                // print(snap.data!.docs[0]['messageList'][0]['message']);
                // return Container();
                // print("${FireService.store.collection('messages').doc("${users[0]}")}");
                // print("${FireService.store.collection('messages/$users/${messageList}')}");
                return Column(
                  children: [
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemBuilder: (context, i){
                          return ListTile(
                            
                            title: Text(data['messageList'][i]['from']),
                            // title: Text("${FireService.store.collection('messages/$users/${messageList[i]}')}"),
                            // title: Text("Malumot"),
                          );
                        },
                        itemCount: data['messageList'].length,
                        ),
                    ),
                    TextFormField(),
                    ElevatedButton(onPressed: ()async{
                      await context.read<SendMessageProvider>().updateList();
                      await context.read<SendMessageProvider>().sendMessage("men", "nima gap");
                      
                    }, child: Icon(Icons.send))
                  ],
                );
              }
            })
    );
  }
}