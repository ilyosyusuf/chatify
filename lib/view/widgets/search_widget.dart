import 'package:chatify/providers/send_message_provider.dart';
import 'package:chatify/view/pages/secondpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (context, i) {
            List setList =
                context.watch<SendMessageProvider>().setList.toList();
            var profunc = context.read<SendMessageProvider>();
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage("${setList[i]['avatar_image_url']}"),
              ),
              title: Text("${setList[i]['firstname']}"),
              subtitle: Text("${setList[i].id}"),
              onTap: () async {
                await profunc.bindUsers(
                    Provider.of<SendMessageProvider>(context, listen: false)
                        .setList
                        .toList()[i]
                        .id);
                await profunc.second();
                if (profunc.messageList.isEmpty) {
                  await profunc.createColl();
                }
                await profunc.createField();
                await profunc.updateList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(
                      name: Provider.of<SendMessageProvider>(context,
                              listen: false)
                          .setList
                          .toList()[i]['firstname'],
                      imageurl: Provider.of<SendMessageProvider>(context,
                              listen: false)
                          .setList
                          .toList()[i]['avatar_image_url'],
                    ),
                  ),
                );
              },
            );
          },
          itemCount:
              context.watch<SendMessageProvider>().setList.toList().length),
    );
  }
}
