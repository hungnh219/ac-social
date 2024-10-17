import 'package:flutter/material.dart';
import 'package:social_app/utils/styles/colors.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 148,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Collection',
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
                return SingleCollection();
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 10);
              },
              itemCount: 10),
          ),
          // CollectionImageCustom()
        ],
      ),
    );
  }
}

class SingleCollection extends StatelessWidget {
  const SingleCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232,
      width: 148,
      child: Column(
        children: [
          Expanded(child: CollectionImageCustom()),
          Center(
            child: Text('hehe'),
          )
        ],
      ),
    );
  }
}
class CollectionImageCustom extends StatelessWidget {
  const CollectionImageCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 148,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/apps-cyclone-logo.png'))),
          ),
          Center(
            child: Text('appscyclone'),
          )
        ],
      ),
    );
  }
}
