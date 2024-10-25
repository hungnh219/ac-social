// screens/home_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/domain/repository/post/post_repository.dart';
import 'package:social_app/presentation/screens/discover/discover_screen.dart';
import 'package:social_app/presentation/screens/home/widgets/home_header_custom.dart';
import 'package:social_app/presentation/screens/home/widgets/post_custom.dart';
import 'package:social_app/presentation/screens/home/widgets/tab_item.dart';
import 'package:social_app/presentation/screens/splash/splash.dart';
import 'package:social_app/presentation/widgets/bottom_app_bar_custom.dart';
import 'package:social_app/presentation/widgets/scaffold_custom.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/utils/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> posts;
  // late CollectionReference postCollection;
  late CollectionReference<Map<String, dynamic>> postCollection;
  // late CollectionReference<Map<String, dynamic>> commentPostCollection;
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // updateKeepAlive();
    // posts = Provider.of<PostRepository>(context).getPostsData();
  }

  Future<void> fetchData() async {
    try {
      // QuerySnapshot querySnapshot = await postCollection.doc('post_000001').collection('lists').get();
      QuerySnapshot querySnapshot = await postCollection.get();
      for (var doc in querySnapshot.docs) {
        // QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('NewPost').doc('post_000001').collection('lists').get();
        // print(userSnapshot);
        // print(userSnapshot.runtimeType);
        // print(doc['user_id']);
        DocumentReference userRef = doc['user_id'];
        // Future<Map<String, dynamic>> userData = userRef.get().then((value) => value.data() as Map<String, dynamic>);
        // print(doc);
        // print(userRef);
        // print(userRef.id);
        // print(userData);
        // userData.then((value) {
        //   userInfo = value;
        //   print(userInfo);
        //   print(userInfo['name']);
        // });
        dynamic userData = await userRef.get();
        print(userData);
        print(userData.runtimeType);
        for (var data in userData.data()!.entries) {
          if (data.key == 'name') {
            print(data.value);
          }
          // print(data.key);
          // print(data.value);
        }
        // print(userSnapshot.data());
      }

    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   // print('test ${userInfo}');
  //   // super.build(context);
  //   return SafeArea(
  //     bottom: false,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Home'),
  //         actions: [
  //           IconButton(
  //             icon: const Icon(Icons.search),
  //             onPressed: () {},
  //           ),
  //           IconButton(
  //             icon: const Icon(Icons.notifications),
  //             onPressed: () {},
  //           ),
  //         ],
  //       ),
  //       body: Column(children: [
  //           const HomeHeaderCustom(),
  //           ElevatedButton(onPressed: () {
  //             fetchData();
              
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(builder: (context) => const SplashScreen())
  //             // );
  //           }, child: Text('logout', style: TextStyle(
  //             color: AppColors.white
  //           ),)),
      //       Expanded(
      //         child: FutureBuilder(
      //           future: serviceLocator.get<PostRepository>().getPostsData(),
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.waiting) {
      //               return Center(child: CircularProgressIndicator());
      //             }
                  
      //             if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //               return Center(child: Text('No data found.'));
      //             }
        
      //             // print(snapshot.data);
      //             // for (var doc in snapshot.data!.docs) {
      //             //   print(doc.data());
      //             // }
      //             return ListView(
      //               children: snapshot.data!.map((doc) {
      //                 print(doc);
      //                 // commentPostCollection = postCollection.doc(doc.id).collection('lists');
      //                 return PostCustom(post: doc);
      //               }).toList(),
      //             );
      //           },
      //         )
      //       ),
      //     ],),
      // ),
  //   );
  // }
   @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: HomeHeaderCustom(),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: AppColors.white,
                  // color: Colors.green.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColors.iric.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: AppColors.iric,
                    unselectedLabelColor: AppColors.erieBlack.withOpacity(0.5),
                    tabs: [
                      TabItem(title: 'Popular',),
                      TabItem(title: 'Trending'),
                      TabItem(title: 'Following'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PostListView(),
            PostListView(),
            PostListView(),
          ],
        ),
      ),
    );
  }
}

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: serviceLocator.get<PostRepository>().getPostsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data found.'));
        }

        return Container(
          color: AppColors.orochimaru,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PostCustom(post: snapshot.data![index]);
              },
            ),
          ),
        );
      },
    );
  }
}
