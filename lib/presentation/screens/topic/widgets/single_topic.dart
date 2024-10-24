import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/topic.dart';

class SingleTopic extends StatelessWidget {
  SingleTopic({super.key, required this.topic, required this.topicIndex});

  TopicModel topic;
  int topicIndex;

  @override
  Widget build(BuildContext context) {
    return topic == null || topicIndex == null ? CircularProgressIndicator() : Stack(
      children: [
        Positioned(
          left: 10,
          // left: MediaQuery.of(context).size.width * 0.05,
          top: 0,
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.9,
            width: 200,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(topic.thumbnail),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
    
        Positioned(
          left: topicIndex % 2 == 0 ? 16 : 168,
          top: 48,
          child: Text(topic.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
          ),
        )
      ],
    );
  }
}