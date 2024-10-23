import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/topic.dart';

class TopicScreen extends StatelessWidget {
  TopicScreen({super.key, required this.topics});

  List<TopicModel>? topics;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Column(
      children: [
        BackButton(),
        Expanded(
            child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 images in a row
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              return Image.network(topics![index].thumbnail);
            },
            itemCount: topics?.length ?? 0),
        )
      ],)
    ));
  }
}