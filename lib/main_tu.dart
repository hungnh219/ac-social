import 'package:flutter/material.dart';
import 'package:social_app/main.dart';
import 'package:social_app/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:social_app/presentation/screens/profile_and_setting/main_profile_screen.dart';
import 'package:social_app/utils/styles/themes.dart';

void main(){
  runApp(const MyTestApp());
}

class MyTestApp extends StatelessWidget{
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // home: EditProfile(),
      home: const ProfileScreen(),
    );
  }
}