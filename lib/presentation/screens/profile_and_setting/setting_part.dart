import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/profile_and_setting/widgets/drawer_item.dart';

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
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
          width: MediaQuery.of(context).size.width * 0.66,
          child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                return DrawerItem(title: drawerItems[index], onPressed: (){});
              }),
        ),
    );
  }
}
