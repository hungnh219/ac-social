// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> posts;

  @override
  void initState() {
    super.initState();
    posts = [
      {
        'username': 'User 1',
        'timestamp': '2 hours ago',
        'title': 'Post 1',
        'description': 'This is post 1',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150'
      },
      {
        'username': 'User 2',
        'timestamp': '1 hours ago',
        'title': 'Post 2',
        'description': 'This is post 2',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150'
      },
      {
        'username': 'User 3',
        'timestamp': '3 hours ago',
        'title': 'Post 3',
        'description': 'This is post 3',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150'
      },
      {
        'username': 'User 4',
        'timestamp': '2 hours ago',
        'title': 'Post 4',
        'description': 'This is post 4',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150',
      },
      {
        'username': 'User 5',
        'timestamp': '1 hours ago',
        'title': 'Post 5',
        'description': 'This is post 5',
        'image': 'https://via.placeholder.com/150',
        'avatar': 'https://via.placeholder.com/150',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
            },
          ),
        ],),
    );
  }
}
