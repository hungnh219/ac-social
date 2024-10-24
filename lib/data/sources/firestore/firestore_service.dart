import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:social_app/domain/entities/comment.dart';
import 'package:social_app/domain/entities/post.dart';
import 'package:social_app/domain/entities/topic.dart';

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

  // Future<UserModel?>? getNewUserData();
  //
  // Future<UserModel?>? getCurrentNewUserData();
  // // No need add to repository
  // Future<UserModel?> fetchNewUserData();
  //
  // Future<void> addCurrentNewUserData(AddUserReq addUserReq);

  Future<TopicModel?>? getTopicData(String topicID);

  Future<List<TopicModel>?>? getTopicsData();

  Future<List<PostModel>?>? getPostsData();

  Future<List<CommentModel>?> getCommentPost(PostModel post);
}

class FirestoreServiceImpl extends FirestoreService {
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  CollectionReference get _usersCollection => _firestoreDB.collection('users');
  CollectionReference _usersFollowersCollection(String uid) {
    return _usersCollection.doc(uid).collection('followers');
  }
  CollectionReference _usersFollowingsCollection(String uid) {
    return _usersCollection.doc(uid).collection('followings');
  }

  CollectionReference get _categoryCollection => _firestoreDB.collection('Category');

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
      DocumentSnapshot userDoc = await _usersCollection.doc(userID).get();

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
    await _usersCollection
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
      await _usersCollection
          .doc(currentUser?.uid)
          .update(updateUserReq.updatedUserData.toMap());
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user data: $e");
      }
    }
  }

  // CollectionReference get _newUsersCollection => _firestoreDB.collection('NewUser');
  //
  // Future<UserModel?> getNewUserData() async {
  //   try {
  //     return await fetchNewUserData();
  //   } on CustomFirestoreException catch (error) {
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //     return null;
  //   }
  // }
  //
  // Future<UserModel?> getCurrentNewUserData() async {
  //   try {
  //     return await fetchNewUserData();
  //   } on CustomFirestoreException catch (error) {
  //     if (error.code == 'user-firestore-not-exist') {
  //       rethrow;
  //     }
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //     return null;
  //   }
  // }
  //
  // // No need add to repository
  // Future<UserModel?> fetchNewUserData() async {
  //   try {
  //     DocumentSnapshot userDoc = await _newUsersCollection.doc("atpFNshDxQOeoPavpluSI2CKrqu2").get();
  //
  //     if (!userDoc.exists) {
  //       throw CustomFirestoreException(
  //         code: 'user-firestore-not-exist',
  //         message: 'User data does not exist in Firestore',
  //       );
  //     }
  //
  //     return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
  //
  // Future<void> addCurrentNewUserData(AddUserReq addUserReq) async {
  //   if (currentUser == null) {
  //     if (kDebugMode) {
  //       print("No user is currently signed in.");
  //     }
  //     return;
  //   }
  //
  //   Map<String, dynamic> userData = addUserReq.newUserData.toMap();
  //   await _usersCollection
  //       .doc(currentUser?.uid)
  //       .set(userData)
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Error pushing user data: $error"));
  // }

  @override
  Future<List<String>> getUserFollowers(String uid) async {
    List<String> followers = [];

    QuerySnapshot<Map<String, dynamic>> followersSnapshot =
    await _usersFollowersCollection(uid).get() as QuerySnapshot<Map<String, dynamic>>;

    for (var doc in followersSnapshot.docs) {
      followers.add(doc.id);
    }

    return followers;
  }

  @override
  Future<List<String>> getUserFollowings(String uid) async {
    List<String> followings = [];

    QuerySnapshot<Map<String, dynamic>> followingsSnapshot =
        await _usersFollowingsCollection(uid).get() as QuerySnapshot<Map<String, dynamic>>;

    for (var doc in followingsSnapshot.docs) {
      followings.add(doc.id);
    }

    return followings;
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
      QuerySnapshot snapshot = await _categoryCollection.get();

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
    // PostModel post = PostModel();
    print('posts: $posts');

    try {
      QuerySnapshot postsSnapshot = await _firestoreDB.collection('Post').get();
      if (postsSnapshot.docs.isEmpty) {
        throw CustomFirestoreException(
          code: 'no-posts',
          message: 'No posts exist in Firestore',
        );
      }

      for (var doc in postsSnapshot.docs) {
        print(doc.id);
        userRef = doc['userRef'];
        userData = userRef.get();
        await userData.then((value) {
          // userInfo = value;
          username = value['name'];
          userAvatar = value['avatar'];
        });

        PostModel post = PostModel(
          postId: doc.id,
          username: username,
          userAvatar: userAvatar,
          content: doc['content'],
          likeAmount: doc['likeAmount'],
          commentAmount: doc['commentAmount'],
          viewAmount: doc['viewAmount'],
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
  Future<List<CommentModel>?> getCommentPost(PostModel post) async {
    List<CommentModel> comments = [];
    DocumentReference commentRef;
    Future<DocumentSnapshot<Object?>> commentData;

    DocumentReference userRef;
    Future<DocumentSnapshot<Object?>> userData;
    String username = '';
    String userAvatar = '';

    try {
      QuerySnapshot commentListSnapshot = await _firestoreDB.collection('NewPost').doc(post.postId).collection('lists').get();
      // Future<Map<String, dynamic>> userData = userRef.get().then((value) => value.data() as Map<String, dynamic>);
      if (commentListSnapshot.docs.isEmpty) {
        throw CustomFirestoreException(
          code: 'no-posts',
          message: 'No posts exist in Firestore',
        );
      }
      for (var doc in commentListSnapshot.docs) {
        // print(doc.id);
        print(doc['comments']);
        for (var comment in doc['comments']) {
          print('1');
          commentRef = comment;
          commentData = commentRef.get();
          await commentData.then((comment) {
            print(comment['content']);
            print(comment['timestamp']);
            print(comment['user_id']);
            userRef = comment['user_id'];
            userData = userRef.get();
            userData.then((userSnapshot) {
              username = userSnapshot['name'];
              userAvatar = userSnapshot['avatar'];
            });
          });


        }
        // userRef = doc['user_id'];
        // userData = userRef.get();
        // await userData.then((value) {
        //   // userInfo = value;
        //   username = value['name'];
        //   userAvatar = value['avatar'];
        // });

        // PostModel post = PostModel(
        //   postId: doc.id,
        //   username: username,
        //   userAvatar: userAvatar,
        //   content: doc['content'],
        //   likeAmount: doc['like_amount'],
        //   commentAmount: doc['comment_amount'],
        //   viewAmount: doc['view_amount'],
        //   image: doc['image'],
        //   timestamp: (doc['timestamp'] as Timestamp).toDate(),
        //   comments: null,
        //   likes: null,
        //   views: null,
        // );
        // // print('post: $post');
        // posts.add(post);
        // topics.add(TopicModel.fromMap(doc.data() as Map<String, dynamic>));
      }

      // print('posts: $posts');
      return null;
      // return postsSnapshot.docs.map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
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
