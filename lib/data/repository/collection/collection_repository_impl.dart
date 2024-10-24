import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/domain/entities/collection.dart';
import 'package:social_app/domain/repository/collection/collection_repository.dart';

import 'package:social_app/service_locator.dart';

import '../../../domain/entities/collection.dart';
import '../../../domain/repository/collection/collection_repository.dart';
import '../../sources/firestore/firestore_service.dart';

class CollectionRepositoryImpl extends CollectionRepository {
  @override
  Future<List<CollectionModel>?>? getCollections() {
    return serviceLocator.get<FirestoreService>().getCollections();
  }

  Future<List<CollectionModel>> getCollectionsData(
      List<String> collectionIDsList) {
    return serviceLocator<FirestoreService>()
        .getCollectionsData(collectionIDsList);
  }
}
