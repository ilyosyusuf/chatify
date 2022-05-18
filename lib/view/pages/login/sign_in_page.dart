import 'package:animate_do/animate_do.dart';
import 'package:chatify/core/components/text_field.dart';
import 'package:chatify/core/constants/colors.dart';
import 'package:chatify/core/extensions/context_extensions.dart';
import 'package:chatify/services/authenservice/write_service.dart';
import 'package:chatify/view/pages/login/change_provider.dart';
import 'package:chatify/view/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? isShown = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: FadeInDown(
                  child: Container(
                      width: context.w,
                      child: Lottie.asset('assets/lotties/signup.json')),
                )),
            Expanded(
              flex: 4,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Form(
                        child: Column(
                          children: [
                            FadeInLeft(
                              child: Container(
                                child: MyTextField.textField(
                                    text: "Enter Email",
                                    controller: emailController,
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: ColorConst.kPrimaryColor,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            FadeInRight(
                              child: Container(
                                child: MyTextField.textField(
                                  text: "Enter Password",
                                  controller: passwordController,
                                  obscure: isShown,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: ColorConst.kPrimaryColor,
                                  ),
                                  iconButton: IconButton(
                                      onPressed: () {
                                        context
                                            .read<ChangeProvider>()
                                            .changed(isShown!);
                                      },
                                      icon: Icon(Icons.remove_red_eye)),
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
                              await WriteService().signIn(
                                  context,
                                  emailController.text,
                                  passwordController.text);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            },
                            text: "Sign In"),
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
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: ColorConst.kPrimaryColor),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
