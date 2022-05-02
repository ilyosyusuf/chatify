import 'package:chatify/core/components/text_field.dart';
import 'package:chatify/providers/send_message_provider.dart';
import 'package:chatify/services/firebase/read_service.dart';
import 'package:chatify/view/pages/secondpage.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: MyTextField.textField(
                    text: 'search...',
                    controller: _searchController,
                    onChanged: (text) async {
                      // context.read<AddProvider>().searchIt(text);
                      // await FireHome().searchIt(_searchController.text);
                      // await context.read<SendMessageProvider>().searchIt(_searchController.text);
                      await Provider.of<SendMessageProvider>(context,
                              listen: false)
                          .searchIt(_searchController.text);
                          setState(() {
                            
                          });
                      // var allData = Provider.of<SendMessageProvider>(context, listen: false).allData;
                      // print(allData);
                      // print(context.watch<SendMessageProvider>().setList);
                      // var list = FireHome().setList.toList();
                      // print(list);
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
                child: FutureBuilder(
                  future: FireHome.getData(),
                  builder: (context, AsyncSnapshot<Map<String, dynamic>> snap) {
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

                      return Container(
                        child: ListView.builder(
                          itemBuilder: (context, i){
                            return ListTile(
                              title: Text("${context.watch<SendMessageProvider>().setList.toList()[i].id}"),
                              onTap: () async{
                                await context.read<SendMessageProvider>().bindUsers(Provider.of<SendMessageProvider>(context, listen: false).setList.toList()[i].id);
                                await context.read<SendMessageProvider>().updateList();
                                // await context.read<SendMessageProvider>().sendMessage("Ilyos", "Hello");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage(name: Provider.of<SendMessageProvider>(context, listen: false).setList.toList()[i]['firstname'])));
                              },
                            );
                          },
                          itemCount: context.watch<SendMessageProvider>().setList.toList().length
                        ),
                      );
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
}
