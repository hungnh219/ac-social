import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app/main.dart';
import 'package:social_app/presentation/screens/auth/cubit/auth_cubit.dart';
import 'package:social_app/presentation/screens/auth/cubit/theme_cubit.dart';
import 'package:social_app/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:social_app/presentation/screens/profile_and_setting/main_profile_screen.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/utils/styles/themes.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory(),
  );

  await initializeDependencies();

  runApp(const MyTestApp());
}

class MyTestApp extends StatelessWidget{
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AuthCubit())
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp(
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            // home: EditProfile(),
            home: const ProfileScreen(),
          )
      ),
    );
  }
}