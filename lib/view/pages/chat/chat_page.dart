import 'package:chatify/core/components/text_field.dart';
import 'package:chatify/core/extensions/context_extensions.dart';
import 'package:chatify/providers/send_message_provider.dart';
import 'package:chatify/services/firebase/fire_service.dart';
import 'package:chatify/services/firebase/read_service.dart';
import 'package:chatify/view/pages/secondpage.dart';
import 'package:chatify/view/widgets/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SendMessageProvider>().updateList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
                height: context.h * 0.07,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: context.w * 0.03),
                    Text(
                      "Chats",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: MyTextField.textField(
                    text: 'search...',
                    controller: _searchController,
                    onChanged: (text) async {
                      await Provider.of<SendMessageProvider>(context,
                              listen: false)
                          .searchIt(_searchController.text);
                      setState(
                        () {},
                      );
                    },
                    onTap: () {
                      _searchController.clear();
                    },
                    iconButton: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                child: StreamBuilder<QuerySnapshot<Map>>(
                  stream: FireService.store
                      .collection('chats')
                      .doc('${FireService.auth.currentUser!.email}')
                      .collection('${FireService.auth.currentUser!.email}')
                      .snapshots(),
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (snap.hasError) {
                      return Center(
                        child: Text(
                          "No Internet",
                        ),
                      );
                    } else {
                      return _searchController.text.isEmpty
                          ? Container(
                              child: ListView.builder(
                                  itemBuilder: (context, i) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            '${snap.data!.docs[i]['avatar_image_url']}'),
                                      ),
                                      title: Text(
                                          '${snap.data!.docs[i]['firstname']}'),
                                      subtitle: Text(
                                          '${snap.data!.docs[i].id}'),
                                      // subtitle: Text(
                                      //     "${context.watch<SendMessageProvider>().last ?? "Send message first"}",
                                      //     overflow: TextOverflow.clip,
                                      //     maxLines: 1),
                                      onTap: () async {
                                        await context
                                            .read<SendMessageProvider>()
                                            .bindUsers(snap.data!.docs[i].id
                                                .toString());
                                        await context
                                            .read<SendMessageProvider>()
                                            .createField();
                                        await context
                                            .read<SendMessageProvider>()
                                            .updateList();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SecondPage(
                                              name: snap.data!.docs[i]
                                                  ['firstname'],
                                              imageurl: snap.data!.docs[i]['avatar_image_url'],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  itemCount: snap.data!.docs.length),
                            )
                          : SearchWidget();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.read<SendMessageProvider>().updateList();
  }
}

