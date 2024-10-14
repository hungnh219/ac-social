import 'package:get_it/get_it.dart';
import 'package:social_app/presentation/screens/auth/cubit/auth_cubit.dart';
import 'data/repository/auth/auth_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'domain/repository/auth/auth.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
