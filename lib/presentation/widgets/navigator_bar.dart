// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/screens/discover/discover_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/presentation/screens/new_post/new_post_screen.dart';
import 'package:social_app/presentation/screens/notification/notification_screen.dart';
import 'package:social_app/presentation/screens/profile_and_setting/main_profile_screen.dart';
import 'package:social_app/utils/styles/colors.dart';

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
    ProfileScreen(),
    // NewPostScreen(),
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
        backgroundColor: AppColors.lavenderBlueShadow,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const NewPostScreen()),
            // );
            context.go('/signin/newpost');
          },
          child: const Icon(Icons.add_box,
            color: AppColors.white,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 76,
        color: AppColors.white,
        shape: const CircularNotchedRectangle(),
        // elevation: 0,
        notchMargin: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: IconButton(
              icon: Icon(
                Icons.home,
                size: 20,
                color: _screenIndex == 0 ?
                  AppColors.lavenderBlueShadow :
                  AppColors.carbon.withOpacity(0.4)),
                onPressed: () {
                  setState(() {
                  _screenIndex = 0;
                  });
                },
              ),
            ),
            Expanded(
              child: IconButton(
              icon: Icon(
                Icons.category_sharp,
                size: 20,
                color: _screenIndex == 1 ?
                  AppColors.lavenderBlueShadow :
                  AppColors.carbon.withOpacity(0.4)
              ),
              onPressed: () {
                setState(() {
                _screenIndex = 1;
                });
              },
              ),
            ),
            Spacer(),
            Expanded(
              child: IconButton(
              icon: Icon(
                Icons.notifications,
                size: 20,
                color: _screenIndex == 2 ?
                  AppColors.lavenderBlueShadow :
                  AppColors.carbon.withOpacity(0.4)

              ),
              onPressed: () {
                setState(() {
                _screenIndex = 2;
                });
              },
              ),
            ),
            Expanded(
              child: IconButton(
              icon: Icon(
                Icons.person,
                size: 20,
                color: _screenIndex == 3 ?
                  AppColors.lavenderBlueShadow :
                  AppColors.carbon.withOpacity(0.4)
              ),
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

