import 'package:awesome_icons/awesome_icons.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chatify/core/components/text_field.dart';
import 'package:chatify/core/constants/colors.dart';
import 'package:chatify/core/extensions/context_extensions.dart';
import 'package:chatify/providers/send_message_provider.dart';
import 'package:chatify/services/firebase/fire_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// class SecondPage extends StatefulWidget {
//   const SecondPage({Key? key}) : super(key: key);

//   @override
//   State<SecondPage> createState() => _SecondPageState();
// }

class SecondPage extends StatelessWidget {
  String? name;
  String? imageurl;
  SecondPage({Key? key, this.name, this.imageurl}) : super(key: key);
  bool issender = false;

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
                      height: context.h * 0.07,
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
                          CircleAvatar(backgroundImage: NetworkImage(imageurl.toString()),),
                          SizedBox(width: size.width * 0.02),
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
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                              dragStartBehavior: DragStartBehavior.down,
                              // reverse: true,
                              // shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return BubbleSpecialThree(
                                  key: UniqueKey(),
                                  text: data['messageList']
                                      // .reversed
                                      .toList()[i]['message'].toString(),
                                  color: data['messageList'][i]['email_from'] == FireService.auth.currentUser!.email.toString() ?Color(0xFF1B97F3) : Colors.grey,
                                  // color: ColorConst.kPrimaryColor,
                                  tail: false,
                                  isSender: data['messageList'][i]['email_from'] == FireService.auth.currentUser!.email.toString() ? true : false,
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                );
                                // return ListTile(
                                //   title: Text(data['messageList']
                                //       .reversed
                                //       .toList()[i]['message']),
                                // );
                              },
                              itemCount: data['messageList'].length,
                            )
                          : Center(
                            child: Lottie.asset('assets/lotties/nomessages.json', width: 200)
                          ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: context.h * 0.065,
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
                                // data['messageList'][i]['email_from'] == FireService.auth.currentUser!.email.toString();
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
