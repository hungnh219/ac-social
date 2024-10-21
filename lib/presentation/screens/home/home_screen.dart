// screens/home_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
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

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  late List<dynamic> posts;
  // late CollectionReference postCollection;
  late dynamic postCollection;
  late dynamic userInfo;
  @override
  void initState() {
    super.initState();
    postCollection = FirebaseFirestore.instance.collection("NewPost");

    // postCollection = FirebaseFirestore.instance.collection("Post").where(field, isEqualTo: value);
    // DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();

  //   CollectionReference users = firestore.collection('users');

  // QuerySnapshot querySnapshot = await users
  //     .select(['name', 'email']) 
  //     .get();
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

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot = await postCollection.get();
      for (var doc in querySnapshot.docs) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('NewUser').doc(doc['user_id']).get();
        print(doc.data());
        print(userSnapshot.data());
      }
      // userInfo = userSnapshot.data();
      for (var doc in querySnapshot.docs) {
        print(doc.data());
        print(userInfo);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('test ${userInfo}');
    super.build(context);
    return SafeArea(
      child:
        ScaffoldCustom(
        body: Column(children: [
          const HomeHeaderCustom(),
          ElevatedButton(onPressed: () {
            fetchData();
          }, child: Text('hehe')),
          Expanded(
            child: StreamBuilder(
              stream: postCollection.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data found.'));
                }

                // print(snapshot.data);
                // for (var doc in snapshot.data!.docs) {
                //   print(doc.data());
                // }
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return PostCustom(post: doc);
                  }).toList(),
                );
              },
            )
          ),
        ],),
        bottomNavBarEnabled: true,
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
