import 'package:chatify/view/pages/homepage.dart';
import 'package:chatify/view/pages/login/sign_up_page.dart';
import 'package:flutter/material.dart';

class MyRoute {
  static final MyRoute _instance = MyRoute._init();
  static MyRoute get instance => _instance;
  
  MyRoute._init();

  Route? onGenerateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return _pages(MyHomePage());
      case '/signup':
        return _pages(SignUpPage());
      default:
    }
  }
    _pages(Widget page){
      return MaterialPageRoute(builder: (context)=> page);
    }

}


  
