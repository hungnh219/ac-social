import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/domain/entities/collection.dart';
import 'package:social_app/domain/repository/collection/collection_repository.dart';
import 'package:social_app/service_locator.dart';

class CollectionRepositoryImpl extends CollectionRepository{
  @override
  Future<List<CollectionModel>?>? getCollections() {
    return serviceLocator.get<FirestoreService>().getCollections();
  }
    
}