import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/drawer_item.dart';
import 'package:social_app/utils/constants/strings.dart';


class SettingPart extends StatefulWidget {
  const SettingPart({super.key});

  @override
  State<SettingPart> createState() => _SettingPartState();
}

class _SettingPartState extends State<SettingPart> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.15),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.66,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerItem(title: AppStrings.email, onPressed: () {}),
            DrawerItem(title: AppStrings.instagram, onPressed: () {}),
            DrawerItem(title: AppStrings.twitter, onPressed: () {}),
            DrawerItem(title: AppStrings.website, onPressed: () {}),
            DrawerItem(title: AppStrings.paypal, onPressed: () {}),
            DrawerItem(title: AppStrings.changePassword, onPressed: () {}),
            DrawerItem(title: AppStrings.aboutIClick, onPressed: () {}),
            DrawerItem(title: AppStrings.termPrivacy, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
