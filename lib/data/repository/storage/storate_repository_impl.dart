import 'dart:io';

import 'package:social_app/data/sources/storage/storage_service.dart';
import 'package:social_app/domain/repository/storage/storage_repository.dart';
import 'package:social_app/service_locator.dart';

class StorageRepositoryImpl extends StorageRepository {
  @override
  Future<String>? uploadPostImage(String folderName, File image) {
    return serviceLocator<StorageService>().uploadPostImage(folderName, image);
  }

  @override
  Future<String>? uploadAvatar(File image, String uid) {
    return serviceLocator<StorageService>().uploadAvatar(image, uid);
  }
}
