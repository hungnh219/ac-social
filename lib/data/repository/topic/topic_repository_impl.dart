import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/domain/entities/topic.dart';
import 'package:social_app/domain/repository/topic/topic_repository.dart';
import 'package:social_app/service_locator.dart';

class TopicRepositoryImpl extends TopicRepository {
  @override
  Future<TopicModel?>? getTopicData(String topicID) {
    print('hehehe');

    return null;
  }

  @override
  Future<List<TopicModel>?>? getTopicsData() {
    // return null;
    return serviceLocator<FirestoreService>().getTopicsData();
  }
}

