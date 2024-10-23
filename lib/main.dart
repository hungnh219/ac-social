import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/config/routes/app_routes.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/presentation/screens/auth/cubit/auth_cubit.dart';
import 'package:social_app/presentation/screens/auth/cubit/theme_cubit.dart';
import 'package:social_app/presentation/screens/category/cubit/category_cubit.dart';
import 'package:social_app/presentation/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:social_app/presentation/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/utils/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => SignInCubit()),
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => CategoryCubit())
      ],
      child: SafeArea(
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            // darkTheme:
            // themeMode: mode,
            // home: const SplashPage()
            routerConfig: MyRouter.router,
            // home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
