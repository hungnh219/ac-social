import '../../entities/collection.dart';

abstract class CollectionRepository{
  Future<List<CollectionModel>> getCollectionsData(List<String> collectionIDsList);
}