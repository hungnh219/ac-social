import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/edit_profile/widgets/svg_icon_button.dart';
import 'package:social_app/utils/constants/icon_path.dart';
import 'package:social_app/utils/styles/themes.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const DrawerItem({
    super.key,
    required this.title, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: AppTheme.drawerItemStyle,
        ),
        leading: SvgIconButton(assetPath: AppIcons.chevronRightButton, onPressed: onPressed),
      ),
    );
  }
}
