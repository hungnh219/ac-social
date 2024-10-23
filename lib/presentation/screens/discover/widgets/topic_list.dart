import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/topic.dart';
import 'package:social_app/presentation/screens/topic/topic_screen.dart';
import 'package:social_app/utils/styles/colors.dart';

class TopicList extends StatelessWidget {
  TopicList({super.key, required this.topics});

  List<TopicModel>? topics;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 148,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Topic',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicScreen(topics: topics)
                    )
                  );
                },
                child: Text('View more', style: TextStyle(color: AppColors.mutedLavender),),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return TopicImageCustom(topic: topics![index],);
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 16);
              },
              itemCount: topics?.length ?? 0),
          ),
          // TopicImageCustom()
        ],
      ),
    );
  }
}

class TopicImageCustom extends StatelessWidget {
  TopicImageCustom({super.key, required this.topic});

  TopicModel topic;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 148,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                // image: AssetImage(
                //   'assets/images/appscyclone.png'
                // ),
                image: NetworkImage(topic.thumbnail),
                fit: BoxFit.cover,
              )
            ),
          ),
          Center(
            child: Text(topic.name),
          )
        ],
      ),
    );
  }
}
