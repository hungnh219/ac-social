import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/utils/constants/icon_path.dart';
import 'package:social_app/utils/styles/colors.dart';

import '../../../../utils/styles/themes.dart';

class InformationBox extends StatelessWidget {
  const InformationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('Bruno Pham', style: AppTheme.blackHeaderStyle),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Da Nang, Vietnam',
            style: AppTheme.profileLocationStyle,
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.lynxWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '1000',
                        style: AppTheme.profileNumberStyle,
                      ),
                      TextSpan(
                        text: '  Followers',
                        style: AppTheme.profileCasualStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '500',
                        style: AppTheme.profileNumberStyle,
                      ),
                      TextSpan(
                        text: '  Following',
                        style: AppTheme.profileCasualStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons.globe),
                ),
                SvgPicture.asset(AppIcons.gradientDot),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons.instagram),
                ),
                SvgPicture.asset(AppIcons.gradientDot),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons.facebook),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
