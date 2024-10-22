import 'package:flutter/material.dart';
import 'package:social_app/utils/styles/colors.dart';

class TopicList extends StatelessWidget {
  const TopicList({super.key});

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
                onTap: () {},
                child: Text('View more', style: TextStyle(color: AppColors.mutedLavender),),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return TopicImageCustom();
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 16);
              },
              itemCount: 10),
          ),
          // TopicImageCustom()
        ],
      ),
    );
  }
}

class TopicImageCustom extends StatelessWidget {
  const TopicImageCustom({super.key});

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
                image: AssetImage(
                  'assets/images/appscyclone.png'
                ),
                fit: BoxFit.cover,
              )
            ),
          ),
          Center(
            child: Text('appscyclone'),
          )
        ],
      ),
    );
  }
}
