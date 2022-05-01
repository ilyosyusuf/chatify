import 'package:chatify/view/pages/login/sign_in_page.dart';
import 'package:chatify/view/pages/login/sign_up_page.dart';
import 'package:chatify/view/pages/profile/fill_profile_page.dart';
import 'package:chatify/view/screens/mainscreen/homescreen.dart';
import 'package:flutter/material.dart';

class MyRoute {
  static final MyRoute _instance = MyRoute._init();
  static MyRoute get instance => _instance;
  
  MyRoute._init();

  Route? onGenerateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return _pages(HomeScreen());
      case '/signup':
        return _pages(SignUpPage());
      case '/signin':
        return _pages(SignInPage());
      case '/fillprofile':
        return _pages(FillProfilePage());
      default:
    }
  }
    _pages(Widget page){
      return MaterialPageRoute(builder: (context)=> page);
    }

}


  
