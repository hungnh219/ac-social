import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/domain/entities/post.dart';
import 'package:social_app/domain/entities/topic.dart';

import '../../../domain/entities/collection.dart';
import '../../../domain/entities/user.dart';
import '../../models/user_firestore/add_user_data.dart';
import '../../models/user_firestore/update_user_req.dart';

abstract class FirestoreService {
  Future<UserModel?>? getUserData(String userID);

  Future<UserModel?>? getCurrentUserData();

  // No need add to repository
  Future<UserModel?> fetchUserData(String userID);

  Future<void> addCurrentUserData(AddUserReq addUserReq);

  Future<void> updateCurrentUserData(UpdateUserReq updateUserReq);

  Future<List<Map<String, String>>> fetchCategoriesData();

  Future<List<String>> getUserFollowers(String uid);

  Future<List<String>> getUserFollowings(String uid);

  Future<List<String>> getUserCollectionIDs(String uid);

  Future<TopicModel?>? getTopicData(String topicID);

  Future<List<TopicModel>?>? getTopicsData();

  Future<List<PostModel>?>? getPostsData();

  Future<List<CollectionModel>> getCollectionsData(List<String> collectionIDsList);

}

class FirestoreServiceImpl extends FirestoreService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;


  // ToDo : Reference Define
  CollectionReference get _usersRef => _firestoreDB.collection('users');
  CollectionReference _usersFollowersRef(String uid) {
    return _usersRef.doc(uid).collection('followers');
  }
  CollectionReference _usersFollowingsRef(String uid) {
    return _usersRef.doc(uid).collection('followings');
  }
  CollectionReference _usersCollectionsRef(String uid) {
    return _usersRef.doc(uid).collection('collections');
  }

  CollectionReference get _categoryRef => _firestoreDB.collection('Category');

  CollectionReference get _collectionRef => _firestoreDB.collection('Collection');
  CollectionReference _collectionPostsRef(String collectionId) {
    return _usersRef.doc(collectionId).collection('posts');
  }

  CollectionReference get _postRef => _firestoreDB.collection('NewPost');


  // ToDo: Service Functions
  @override
  Future<UserModel?> getUserData(String userID) async {
    try {
      return await fetchUserData(userID);
    } on CustomFirestoreException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      return await fetchUserData(currentUser!.uid);
    } on CustomFirestoreException catch (error) {
      if (error.code == 'new-user') {
        rethrow;
      }
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  // No need add to repository
  @override
  Future<UserModel?> fetchUserData(String userID) async {
    try {
      DocumentSnapshot userDoc = await _usersRef.doc(userID).get();

      if (!userDoc.exists) {
        throw CustomFirestoreException(
          code: 'new-user',
          message: 'User data does not exist in Firestore',
        );
      }

      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addCurrentUserData(AddUserReq addUserReq) async {
    if (currentUser == null) {
      if (kDebugMode) {
        print("No user is currently signed in.");
      }
      return;
    }

    Map<String, dynamic> userData = addUserReq.newUserData.toMap();
    await _usersRef
        .doc(currentUser?.uid)
        .set(userData)
        .then((value) => print("User Added"))
        .catchError((error) => print("Error pushing user data: $error"));
  }

  @override
  Future<void> updateCurrentUserData(UpdateUserReq updateUserReq) async {
    if (currentUser == null) {
      if (kDebugMode) {
        print("No user is currently signed in.");
      }
      return;
    }

    try {
      await _usersRef
          .doc(currentUser?.uid)
          .update(updateUserReq.updatedUserData.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user data: $e");
      }
    }
  }

  @override
  Future<List<String>> getUserFollowers(String uid) async {
    List<String> followers = [];

    QuerySnapshot<Map<String, dynamic>> followersSnapshot =
    await _usersFollowersRef(uid).get() as QuerySnapshot<Map<String, dynamic>>;

    for (var doc in followersSnapshot.docs) {
      followers.add(doc.id);
    }

    return followers;
  }

  @override
  Future<List<String>> getUserFollowings(String uid) async {
    List<String> followings = [];

    QuerySnapshot<Map<String, dynamic>> followingsSnapshot =
        await _usersFollowingsRef(uid).get() as QuerySnapshot<Map<String, dynamic>>;

    for (var doc in followingsSnapshot.docs) {
      followings.add(doc.id);
    }

    return followings;
  }

  @override
  Future<List<String>> getUserCollectionIDs(String uid) async {
    List<String> collections = [];

    QuerySnapshot<Map<String, dynamic>> collectionsSnapshot =
    await _usersCollectionsRef(uid).get() as QuerySnapshot<Map<String, dynamic>>;

    for (var doc in collectionsSnapshot.docs) {
      collections.add(doc.id);
    }

    if (kDebugMode) {
      print(collections.toString());
    }

    return collections;
  }

  //////////////////////////////////////////////////////////////////////////

  @override
  Future<TopicModel?> getTopicData(String topicID) async {
    try {
      DocumentSnapshot topicDoc =
          await _firestoreDB.collection('NewTopic').doc(topicID).get();

      if (!topicDoc.exists) {
        throw CustomFirestoreException(
          code: 'topic-not-exist',
          message: 'Topic data does not exist in Firestore',
        );
      }

      return TopicModel.fromMap(topicDoc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TopicModel>?>? getTopicsData() async {
    try {
      QuerySnapshot topicsSnapshot =
          await _firestoreDB.collection('NewTopic').get();

      if (topicsSnapshot.docs.isEmpty) {
        throw CustomFirestoreException(
          code: 'no-topics',
          message: 'No topics exist in Firestore',
        );
      }

      return topicsSnapshot.docs
          .map((doc) => TopicModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, String>>> fetchCategoriesData() async {
    List<Map<String, String>> categories = [];
    try {
      QuerySnapshot snapshot = await _categoryRef.get();

      for (var doc in snapshot.docs) {
        if (doc.exists) {}
        categories.add({
          'id': doc.id, // Lấy ID của tài liệu
          'name': doc['name'], // Lấy trường 'name'
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error get category list: $e");
      }
    }
    if (kDebugMode) {
      print(categories);
    }
    return categories;
  }

  @override
  Future<List<PostModel>?>? getPostsData() async {
    List<PostModel> posts = [];

    DocumentReference userRef;
    Future<DocumentSnapshot<Object?>> userData;
    String username = '';
    String userAvatar = '';
    print('posts: $posts');

    try {
      QuerySnapshot postsSnapshot = await _postRef.get();
      // Future<Map<String, dynamic>> userData = userRef.get().then((value) => value.data() as Map<String, dynamic>);

      if (postsSnapshot.docs.isEmpty) {
        throw CustomFirestoreException(
          code: 'no-posts',
          message: 'No posts exist in Firestore',
        );
      }

      for (var doc in postsSnapshot.docs) {
        userRef = doc['user_id'];
        userData = userRef.get();
        await userData.then((value) {
          // userInfo = value;
          username = value['name'];
          userAvatar = value['avatar'];
        });

        PostModel post = PostModel(
          username: username,
          userAvatar: userAvatar,
          content: doc['content'],
          likeAmount: doc['like_amount'],
          commentAmount: doc['comment_amount'],
          viewAmount: doc['view_amount'],
          image: doc['image'],
          timestamp: (doc['timestamp'] as Timestamp).toDate(),
          comments: null,
          likes: null,
          views: null,
        );
        // print('post: $post');
        posts.add(post);
        // topics.add(TopicModel.fromMap(doc.data() as Map<String, dynamic>));
      }

      // print('posts: $posts');
      return posts;
      // return postsSnapshot.docs.map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CollectionModel>> getCollectionsData(List<String> collectionIDsList) async {
    List<CollectionModel> collections = [];

    try {
      for (String collectionID in collectionIDsList) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _collectionRef.doc(collectionID).get() as DocumentSnapshot<Map<String, dynamic>>;

        if (snapshot.exists && snapshot.data() != null) {
          CollectionModel collection = CollectionModel.fromMap(snapshot.data()!);
          collections.add(collection);  // Add to list of collections
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching collection data: $e");
      }
    }

    if (kDebugMode) {
      print(collections);  // Debugging output
    }

    return collections;  // Return the list of CollectionModel objects
  }

}

class CustomFirestoreException implements Exception {
  final String code;
  final String message;

  CustomFirestoreException({required this.code, required this.message});

  @override
  String toString() {
    return 'CustomFirestoreException($code): $message';
  }
}
