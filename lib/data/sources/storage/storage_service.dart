import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app/data/sources/storage/method.dart';

abstract class StorageService {
  Future<String> uploadFile(File file, String path);
  Future<void> deleteFile(String path);
}

// class StorageServiceImpl implements StorageService {
//   // @override
//   // Future<String> uploadFile(File file) async {
//   //   uploadImage('Image', file);
//   // }

//   // @override
//   // Future<String> uploadUserAvatar(File file) async {
//   //   uploadImage('User', file);
//   // }
// }


