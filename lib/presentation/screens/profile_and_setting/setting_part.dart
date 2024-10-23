import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/drawer_item.dart';

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

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const DrawerItem({
    super.key,
    required this.title, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.66,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ListTile(
            contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 16),
            title: Text(
              title,
              style: AppTheme.drawerItemStyle,
            ),
            trailing: SvgIconButton(assetPath: AppIcons.whiteChevronRightButton, iconSize: 36, onPressed: onPressed),
          ),
        ),
      ),
    );
  }
}
