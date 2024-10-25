import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/topic.dart';
import 'package:social_app/presentation/screens/topic/widgets/single_topic.dart';
import 'package:social_app/presentation/screens/topic/widgets/topic_horizontal_image.dart';
import 'package:social_app/utils/styles/colors.dart';
import 'package:social_app/utils/styles/text_style.dart';

class TopicScreen extends StatelessWidget {
  TopicScreen({super.key, required this.topics});

  List<TopicModel>? topics;

  @override
  Widget build(BuildContext context) {
    // print('topics: $topics');
    // print('topics: ${topics![1].name}');
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              color: AppColors.carbon,  
            ),

            topics == null ?
              CircularProgressIndicator() :
              Expanded(
                child: ListView.builder(
                  itemBuilder: (
                    BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: AppColors.carbon.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(image: 
                                    NetworkImage(topics![index].thumbnail), fit: BoxFit.cover
                                  )
                                ),
                              ),
                            ),
                            Positioned(
                              // left: 50,
                              top: 48,
                              left: (index % 2 == 0) ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.6,
                              // child: Text(topics![index].name)
                              child: Text(topics![index].name.toUpperCase(), style: AppTextStyle.uppercaseWhiteBigStyle)
                            ),
                          ],
                        ),
                      );
                    },
                  itemCount: topics?.length ?? 0
                ),
              ),
          ],
        )
      )
    );
  }
}