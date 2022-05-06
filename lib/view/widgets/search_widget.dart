
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
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage("${context.watch<SendMessageProvider>().setList.toList()[i]['avatar_image_url']}"),),
                title: Text("${context.watch<SendMessageProvider>().setList.toList()[i]['firstname']}"),
                subtitle: Text(
                    "${context.watch<SendMessageProvider>().setList.toList()[i].id}"),
                onTap: () async {
                  await context
                      .read<SendMessageProvider>()
                      .bindUsers(Provider.of<
                                  SendMessageProvider>(
                              context,
                              listen: false)
                          .setList
                          .toList()[i]
                          .id);
                  if (context
                      .read<SendMessageProvider>()
                      .messageList
                      .isEmpty) {
                    await context
                        .read<SendMessageProvider>()
                        .createColl();
                  }
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
                          name: Provider.of<
                                      SendMessageProvider>(
                                  context,
                                  listen: false)
                              .setList
                              .toList()[i]['firstname'],
                           imageurl: Provider.of<
                                      SendMessageProvider>(
                                  context,
                                  listen: false)
                              .setList
                              .toList()[i]['avatar_image_url'],
                          ),
                    ),
                  );
                },
              );
            },
            itemCount: context
                .watch<SendMessageProvider>()
                .setList
                .toList()
                .length),
      );
  }
}