import 'package:get_it/get_it.dart';
import 'data/repository/auth/auth_repository_impl.dart';
import 'data/repository/user/user_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'data/sources/firestore/firestore_service.dart';
import 'domain/repository/auth/auth.dart';
import 'domain/repository/user/user.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  serviceLocator.registerSingleton<FirestoreService>(FirestoreServiceImpl());

  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  serviceLocator.registerSingleton<UserRepository>(UserRepositoryImpl());

}
