// main.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/presentation/screens/auth/auth.dart';
import 'package:social_app/presentation/screens/auth/cubit/auth_cubit.dart';
import 'package:social_app/presentation/screens/auth/cubit/theme_cubit.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:social_app/utils/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await initializeDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AuthCubit())
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp(
          debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // darkTheme:
        // themeMode: mode,
        // home: const SplashPage()
          home: AuthScreen()
      )),
    );
  }
}