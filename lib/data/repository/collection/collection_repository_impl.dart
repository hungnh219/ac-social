
import 'package:social_app/service_locator.dart';

import '../../../domain/entities/collection.dart';
import '../../../domain/repository/collection/collection_repository.dart';
import '../../sources/firestore/firestore_service.dart';

class CollectionRepositoryImpl extends CollectionRepository{
  @override
  Future<List<CollectionModel>> getCollectionsData(List<String> collectionIDsList){
    return serviceLocator<FirestoreService>().getCollectionsData(collectionIDsList);
  }
}