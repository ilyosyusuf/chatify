import 'package:awesome_icons/awesome_icons.dart';
import 'package:chatify/core/base/base_view.dart';
import 'package:chatify/view/pages/chat/chat_page.dart';
import 'package:chatify/view/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _controller = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: HomeScreen,
        OnPageBuilder: (context, widget) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ChatPage(),
                Container(color: Colors.yellow),
                SettingsPage(),
              ],
            ),
            bottomNavigationBar: SlidingClippedNavBar(
              backgroundColor: Colors.white,
              onButtonPressed: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _controller.animateToPage(selectedIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad);
              },
              iconSize: 25,
              activeColor: Color(0xFF01579B),
              selectedIndex: selectedIndex,
              barItems: [
                BarItem(
                  icon: FontAwesomeIcons.comment,
                  title: 'Chats',
                ),
                BarItem(
                  icon: FontAwesomeIcons.users,
                  title: 'Contacts',
                ),
                BarItem(
                  icon: FontAwesomeIcons.list,
                  title: 'More',
                ),
              ],
            ),
          );
        });
  }
}
