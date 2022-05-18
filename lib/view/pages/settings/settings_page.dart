import 'package:chatify/core/components/box_full_decoration.dart';
import 'package:chatify/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
                    const Text(
                      "More",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                )),
            Expanded(
                flex: 9,
                child: Container(
                  child: Column(children: [
                    Container(
                      height: context.h * 0.12,
                      margin: EdgeInsets.all(20.0),
                      alignment: Alignment.center,
                      decoration: BoxAllDecoration.decor(Colors.white),
                      child: const ListTile(
                        title: Text("hello"),
                        subtitle: Text("subb"),
                      ),
                    )
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
