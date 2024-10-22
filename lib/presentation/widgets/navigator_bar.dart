import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/discover/discover_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/presentation/screens/notification/notification_screen.dart';
import 'package:social_app/presentation/screens/profile_and_setting/main_profile_screen.dart';

class NavigatorBarCustom extends StatefulWidget {
  const NavigatorBarCustom({super.key});

  @override
  State<NavigatorBarCustom> createState() => _NavigatorBarCustomState();
}

class _NavigatorBarCustomState extends State<NavigatorBarCustom> {
  int _screenIndex = 0;

  List<Widget> _screens = [
    HomeScreen(),
    DiscoverScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      // body: _screens[_screenIndex],
      body: IndexedStack(
        index: _screenIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.transparent,
          onPressed: () {},
          child: const Icon(Icons.add,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 76,
        color: Colors.yellow,
        shape: const CircularNotchedRectangle(),
        // elevation: 0,
        notchMargin: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: IconButton(
              icon: Icon(Icons.home, size: 20, color: _screenIndex == 0 ? Colors.red : Colors.grey),
              onPressed: () {
                setState(() {
                _screenIndex = 0;
                });
              },
              ),
            ),
            Expanded(
              child: IconButton(
              icon: Icon(Icons.category_sharp, size: 20, color: _screenIndex == 1 ? Colors.red : Colors.grey),
              onPressed: () {
                setState(() {
                _screenIndex = 1;
                });
              },
              ),
            ),
            Expanded(
              child: IconButton(
              icon: Icon(Icons.notifications, size: 20, color: _screenIndex == 2 ? Colors.red : Colors.grey),
              onPressed: () {
                setState(() {
                _screenIndex = 2;
                });
              },
              ),
            ),
            Expanded(
              child: IconButton(
              icon: Icon(Icons.person, size: 20, color: _screenIndex == 3 ? Colors.red : Colors.grey),
              onPressed: () {
                setState(() {
                _screenIndex = 3;
                });
              },
              ),
            ),
          ],
        ),
      )
    );
  }
}

