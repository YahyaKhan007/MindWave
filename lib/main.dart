import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:music_app_using_bloc/bloc/change_screen_index/change_screen_index_bloc.dart';
import 'package:music_app_using_bloc/bloc/play_song_bloc/play_song_bloc.dart';
import 'package:music_app_using_bloc/bloc/theme_bloc/theme_bloc.dart';
import 'package:music_app_using_bloc/bloc/upload_music/upload_music_bloc.dart';
import 'package:music_app_using_bloc/firebase_options.dart';
import 'package:music_app_using_bloc/views/music/playerControllerStates.dart';
import 'package:music_app_using_bloc/views/views.dart';

import 'views/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ScreenUtilInit(
      designSize: const Size(350, 690),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => ThemeBloc()..add(InitTheme()))),
        BlocProvider(create: ((context) => ChangeScreenIndexBloc())),
        BlocProvider(create: ((context) => PlaySongBloc())),
        BlocProvider(
            create: ((context) => UploadMusicBloc(AudioPickerUtils()))),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeData currentTheme = state.themeData == ThemeData.light()
              ? ThemeUtils.getLightTheme()
              : ThemeUtils.getDarkTheme();
          return GetMaterialApp(
            initialBinding: ControllerBindings(),
            debugShowCheckedModeBanner: false,
            title: 'Mind Wave',
            theme: currentTheme,
            darkTheme: ThemeUtils.getDarkTheme(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PlayerController());
  }
}
