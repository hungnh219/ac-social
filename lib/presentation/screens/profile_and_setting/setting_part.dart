import 'package:flutter/material.dart';

import '../../../utils/constants/icon_path.dart';
import '../../../utils/styles/themes.dart';
import '../../widgets/profile_and_setting/svg_icon_button.dart';

class SettingPart extends StatefulWidget {
  const SettingPart({super.key});

  @override
  State<SettingPart> createState() => _SettingPartState();
}

class _SettingPartState extends State<SettingPart> {
  List<String> drawerItems = [
    'Email',
    'Instagram',
    'Twitter',
    'Website',
    'Paypal',
    'Change password',
    'About i.click',
    "Term & privacy"
  ];

  @override
  Widget build(BuildContext context) {
    return  Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.125),
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                return DrawerItem(title: drawerItems[index], onPressed: (){});
              }),
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
