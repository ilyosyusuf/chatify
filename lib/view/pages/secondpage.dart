import 'package:awesome_icons/awesome_icons.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chatify/core/components/text_field.dart';
import 'package:chatify/core/constants/colors.dart';
import 'package:chatify/providers/send_message_provider.dart';
import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class SecondPage extends StatefulWidget {
//   const SecondPage({Key? key}) : super(key: key);

//   @override
//   State<SecondPage> createState() => _SecondPageState();
// }

class SecondPage extends StatelessWidget {
  String? name;
  SecondPage({Key? key, this.name}) : super(key: key);

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // print(object)
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String sort1 = context.watch<SendMessageProvider>().sortList.first;
    String sort2 = context.watch<SendMessageProvider>().sortList.last;
    List messageList = context.watch<SendMessageProvider>().messageList;
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map>>(
        stream: FireService.store
            .collection('messages')
            .doc('${sort1 + sort2}')
            .collection('coll')
            .snapshots(),
        // stream: FireService.store.collection('/messages/a@gmail.comc@gmail.com/coll').snapshots(),
        // doc('${sort1+sort2}').collection('messageList').snapshots(),

        // collection('messages/${context.watch<SendMessageProvider>().sortList.first+context.watch<SendMessageProvider>().sortList.last}/messageList').snapshots(),
        // .orderBy("sent_at")
        // .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snap.hasError) {
            return const Center(
              child: Text("ERROR"),
            );
          } else {
            var data = snap.data!.docs[0];
            // print("DAAATTTAAAA $data");
            // users.sort();
            print("${sort1 + sort2}");
            // print(data[0]['from']);
            // print(snap.data!.docs[0]);
            // print(snap.data!.docs[0]['messageList'][0]['message']);
            // return Container();
            // print("${FireService.store.collection('messages').doc("${users[0]}")}");
            // print("${FireService.store.collection('messages/$users/${messageList}')}");
            return SafeArea(
              child: Column(
                children: [
                  Container(
                      height: size.height * 0.07,
                      color: Colors.white,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.chevron_left_rounded),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            },
                          ),
                          Text(
                            name.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.group_add_rounded),
                            onPressed: () {},
                          ),
                        ],
                      )),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/tgbackground.png'))
                      ),
                      // height: 500,
                      child: data['messageList'].isNotEmpty
                          ? ListView.builder(
                              dragStartBehavior: DragStartBehavior.down,
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return BubbleSpecialThree(
                                  text: data['messageList']
                                      .reversed
                                      .toList()[i]['message'].toString(),
                                  color: Color(0xFF1B97F3),
                                  // color: ColorConst.kPrimaryColor,
                                  tail: false,
                                  isSender: FireService.auth.currentUser!.email.toString() == data['messageList'][i]['email_from'],
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                );
                                // return ListTile(
                                //   title: Text(data['messageList']
                                //       .reversed
                                //       .toList()[i]['message']),
                                // );
                              },
                              itemCount: data['messageList'].length,
                            )
                          : Container(
                              child: Center(
                                child: Text("No Data Yet"),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: size.height * 0.065,
                          child: MyTextField.textField(
                              text: "Write a message", controller: _controller),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: CircleAvatar(
                              radius: size.width * 0.065,
                              backgroundColor: ColorConst.kPrimaryColor,
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.white,
                              )),
                          onTap: () async {
                            await context
                                .read<SendMessageProvider>()
                                .updateList();
                            await context
                                .read<SendMessageProvider>()
                                .sendMessage("men", _controller.text);
                          },
                        ),
                      )
                      //                   ElevatedButton(
                      // onPressed: () async {
                      //   await context.read<SendMessageProvider>().updateList();
                      //   await context
                      //       .read<SendMessageProvider>()
                      //       .sendMessage("men", _controller.text);
                      // },
                      // child: Icon(Icons.send)),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
