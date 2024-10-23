import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/domain/entities/topic.dart';
import 'package:social_app/domain/repository/topic/topic_repository.dart';
import 'package:social_app/presentation/screens/discover/widgets/collection_list.dart';
import 'package:social_app/presentation/screens/discover/widgets/topic_list.dart';
import 'package:social_app/presentation/widgets/scaffold_custom.dart';
import 'package:social_app/service_locator.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  // late List<TopicModel>? topics;

  @override
  void initState() {
    super.initState();
    // topics = fetchTopicData();
    // topics = serviceLocator<TopicRepository>().getTopicsData();
    // serviceLocator<TopicRepository>().getTopicsData()?.then((value) {
    //   setState(() {
    //     topics = value;
    //   });
    // });
    // serviceLocator<UserRepository>().getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    // print('topics: $topics');
    return SafeArea(child: 
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<TopicModel>?>(
                future: serviceLocator<TopicRepository>().getTopicsData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No topics available');
                  } else {
                    // topics = snapshot.data;
                    return TopicList(topics: snapshot.data);
                  }
                }
              ),
              // TopicList(topics: topics),
              CollectionList()
          ],),
        ), 
      ),
    );
  }
}

