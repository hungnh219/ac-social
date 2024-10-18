import 'package:flutter/material.dart';

import '../../widgets/profile_and_setting/drawer_item.dart';

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
          itemCount: drawerItems.length,
          itemBuilder: (BuildContext context, int index) {
            return DrawerItem(title: drawerItems[index], onPressed: (){});
          }),
    );
  }
}
//
// class CustomAppBar extends StatelessWidget {
//   final VoidCallback onMenuPressed;
//
//   const CustomAppBar({Key? key, required this.onMenuPressed}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56, // Height of the AppBar
//       color: Colors.blue, // AppBar background color
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.menu, color: Colors.white),
//             onPressed: onMenuPressed,
//           ),
//           Expanded(
//             child: Center(
//               child: Text(
//                 'Custom Drawer',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
