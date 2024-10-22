import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/discover/discover_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/presentation/screens/post_detail/post_detail_screen.dart';
import 'package:social_app/presentation/screens/profile_and_setting/main_profile_screen.dart';

class ScaffoldCustom extends StatefulWidget {
  final Widget body;
  final AppBar? appBar;
  final bool bottomNavBarEnabled;

  const ScaffoldCustom({
    Key? key,
    required this.body,
    this.appBar,
    this.bottomNavBarEnabled = false,
  }) : super(key: key);

  @override
  State<ScaffoldCustom> createState() => _ScaffoldCustomState();
}

class _ScaffoldCustomState extends State<ScaffoldCustom> with AutomaticKeepAliveClientMixin<ScaffoldCustom> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
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
      bottomNavigationBar: widget.bottomNavBarEnabled
        ? BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 76,
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home, size: 20, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.category_sharp, size: 20, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DiscoverScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, size: 20, color: Colors.black),
                  onPressed: () {

                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person, size: 20, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen())
                    );
                  },
                ),
              ],
            ),
          )
        : null, // No bottom navigation if it's not enabled
    );
  }
  @override
  bool get wantKeepAlive => true;
}
