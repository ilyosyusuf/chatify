// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class FillProfilePage extends StatelessWidget {
//   FillProfilePage({Key? key}) : super(key: key);

//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   XFile? image;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Container());
//   }
// }

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:chatify/core/components/box_decoration_widget.dart';
import 'package:chatify/core/components/text_field.dart';
import 'package:chatify/core/constants/colors.dart';
import 'package:chatify/core/extensions/context_extensions.dart';
import 'package:chatify/services/authenservice/write_service.dart';
import 'package:chatify/view/pages/login/change_provider.dart';
import 'package:chatify/view/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FillProfilePage extends StatelessWidget {
  FillProfilePage({Key? key}) : super(key: key);

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: StatefulBuilder(
                builder: ((context, setState) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    child: FadeInDown(
                      child: Stack(
                        children: [
                          SizedBox(
                            child: image != null
                                ? CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: MediaQuery.of(context).size.width * 0.15,
                                    backgroundImage:
                                        FileImage(File(image!.path)))
                                : CircleAvatar(
                                    radius: MediaQuery.of(context).size.width * 0.15,
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                  ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () async {
                                image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        child: Column(
                          children: [
                            FadeInLeft(
                              child: Container(
                                // decoration: MyBoxDecoration.decor,
                                child: MyTextField.textField(
                                  text: "First Name (Required)",
                                  controller: firstnameController,
                                  // validator: "Please, fill the line"
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            FadeInRight(
                              child: Container(
                                child: MyTextField.textField(
                                  text: "Last Name (Optional)",
                                  controller: lastnameController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        child: ElevatedButtonWidget(
                            onPressed: () async {
                              await WriteService().fillProfile(
                                  context,
                                  image!,
                                  firstnameController.text,
                                  lastnameController.text);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            },
                            text: "Save"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FadeInUpBig(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: ColorConst.kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
