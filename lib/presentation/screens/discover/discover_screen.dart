import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/discover/widgets/collection_list.dart';
import 'package:social_app/presentation/screens/discover/widgets/topic_list.dart';
import 'package:social_app/presentation/widgets/scaffold_custom.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
      ScaffoldCustom(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              TopicList(),
              CollectionList()
          ],),
        ), 
        bottomNavBarEnabled: true,
      ),
    );
  }
}

