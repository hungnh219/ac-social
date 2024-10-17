// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/presentation/screens/discover/discover_screen.dart';
import 'package:social_app/presentation/screens/home/widgets/home_header_custom.dart';
import 'package:social_app/presentation/screens/home/widgets/post_custom.dart';
import 'package:social_app/presentation/widgets/bottom_app_bar_custom.dart';
import 'package:social_app/presentation/widgets/scaffold_custom.dart';
import 'package:social_app/utils/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> posts;

  @override
  void initState() {
    super.initState();
    posts = [
      {
        'username': 'User 1',
        'timestamp': '2 hours ago',
        'title': 'Post 1',
        'description': 'This is post 1',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150'
      },
      {
        'username': 'User 2',
        'timestamp': '1 hours ago',
        'title': 'Post 2',
        'description': 'This is post 2',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150'
      },
      {
        'username': 'User 3',
        'timestamp': '3 hours ago',
        'title': 'Post 3',
        'description': 'This is post 3',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150'
      },
      {
        'username': 'User 4',
        'timestamp': '2 hours ago',
        'title': 'Post 4',
        'description': 'This is post 4',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150',
      },
      {
        'username': 'User 5',
        'timestamp': '1 hours ago',
        'title': 'Post 5',
        'description': 'This is post 5',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      // Scaffold(
      //   extendBody: true,
      //   // backgroundColor: AppColors.bauhaus,
      //   backgroundColor: Colors.grey.withOpacity(0.25),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.add,
        //   ),
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: BottomAppBar(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   height: 76,
        //   color: AppColors.white,
        //   shape: const CircularNotchedRectangle(),
        //   notchMargin: 5,
        //   child: Row(
        //     mainAxisSize: MainAxisSize.max,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       IconButton(
        //         icon: const Icon(
        //           Icons.home,
        //           color: Colors.black,
        //           size: 20,
        //         ),
        //         onPressed: () {},
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.category_sharp,
        //           color: Colors.black,
        //           size: 20,
        //         ),
        //         onPressed: () {},
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.notifications,
        //           color: Colors.black,
        //           size: 20,
        //         ),
        //         onPressed: () {},
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.person,
        //           color: Colors.black,
        //           size: 20,
        //         ),
        //         onPressed: () {},
        //       ),
        //     ],
        //   ),
        // ),

          // bottom nav custom
        //   bottomNavigationBar: BottomNavBarCustom(
        //   currentIndex: 0, // Set the active index
        //   onTap: (index) {
        //     // Handle navigation
        //     if (index == 0) {
        //       Navigator.pushNamed(context, '/home');
        //     } else if (index == 1) {
        //       // Navigator.pushNamed(context, '/discover');
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
        //     } else if (index == 2) {
        //       Navigator.pushNamed(context, '/notifications');
        //     } else if (index == 3) {
        //       Navigator.pushNamed(context, '/profile');
        //     }
        //   },
        // ),
        ScaffoldCustom(
        body: Column(children: [
          const HomeHeaderCustom(),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCustom(post: posts[index]);
              },
            ),
          ),
        ],),
        bottomNavBarEnabled: true,
      )
    );
  }
}
