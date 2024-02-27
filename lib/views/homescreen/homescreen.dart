import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app_using_bloc/bloc/play_song_bloc/play_song_bloc.dart';
import 'package:music_app_using_bloc/views/auth_screen/login.dart';

import '../../bloc/change_screen_index/change_screen_index_bloc.dart';
import '../../bloc/theme_bloc/theme_bloc.dart';
import '../../models/music_model.dart';
import '../Utils/utils.dart';
import '../views.dart';

class HomeScreen extends StatefulWidget {
  final MusicModel? musicModel;

  const HomeScreen({super.key, required this.musicModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      MusicLibrary(
        folders: widget.musicModel,
      ),
      BlocBuilder<PlaySongBloc, PlaySongState>(
        builder: (context, state) {
          return const MusicPlayer(
              // currentSong: state.currentSong,
              );
        },
      ),
    ];
    return AdvancedDrawer(
        // backdropColor: Colors.white,
        openRatio: 0.65,
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface,
                // Theme.of(context).colorScheme.background,
              ],
            ),
          ),
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    onTap: () {
                      context
                          .read<ChangeScreenIndexBloc>()
                          .add(const NextPageIndecChangeScreen(index: 0));
                      _advancedDrawerController.hideDrawer();
                    },
                    title: Text(
                      "Music Library",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    leading: const Icon(Icons.music_note),
                  ),
                  ListTile(
                    onTap: () {
                      context
                          .read<ChangeScreenIndexBloc>()
                          .add(const NextPageIndecChangeScreen(index: 1));
                      _advancedDrawerController.hideDrawer();
                    },
                    leading: const Icon(Icons.mic_external_on_outlined),
                    title: Text(
                      'Music Screen',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    trailing: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                      return Switch(
                          value: state.themeData == ThemeData.light()
                              ? false
                              : true,
                          onChanged: (value) {
                            if (!value) {
                              context.read<ThemeBloc>().add(LightTheme());
                            } else {
                              context.read<ThemeBloc>().add(DarkTheme());
                            }
                          });
                    }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () async {
                      FirebaseAuth.instance.currentUser != null
                          ? await FirebaseAuth.instance
                              .signOut()
                              .then((value) => showSnackbar())
                          : Get.to(() {
                              return OneClicLogin(
                                musicModel: widget.musicModel,
                              );
                            });
                    },
                    leading: FirebaseAuth.instance.currentUser == null
                        ? const Icon(Icons.login_outlined)
                        : const Icon(Icons.logout_outlined),
                    title: Text(
                      FirebaseAuth.instance.currentUser == null
                          ? 'Developer mode ?'
                          : 'Logout Dev mode',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                ],
              ),
              Positioned(
                  top: 20.h,
                  right: 00,
                  child: Theme.of(context).brightness == Brightness.dark
                      ? Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: AppShadows.blackThemeShadow),
                          child: CircleAvatar(
                            radius: 100.sp,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            child: Transform.rotate(
                              angle: 340,
                              child: Image.asset(
                                "assets/light_off.png",
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: AppShadows.blackThemeShadow),
                          child: CircleAvatar(
                            radius: 100.sp,
                            backgroundColor: Colors.yellow.withOpacity(0.6),
                            child: Transform.rotate(
                              angle: 340,
                              child: Image.asset(
                                "assets/light_on.png",
                                // color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ))
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            toolbarHeight: 60.h,
            centerTitle: true,
            title: BlocBuilder<ChangeScreenIndexBloc, ChangeScreenIndexState>(
              builder: (context, state) {
                return state.index == 0
                    ? Text(
                        "VIBES",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                            letterSpacing: -1),
                      )
                    : BlocBuilder<PlaySongBloc, PlaySongState>(
                        builder: (context, songState) {
                          return Text(
                            songState.modeName != ""
                                ? songState.modeName.toUpperCase()
                                : "Music Library",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      );
              },
            ),
            leading: Container(
              margin: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: Theme.of(context).brightness == Brightness.dark
                      ? AppShadows.blackThemeShadow
                      : AppShadows.lightThemeShadow),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                // radius: 10.r,
                child: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          color: Theme.of(context).colorScheme.onSurface,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          body: BlocBuilder<ChangeScreenIndexBloc, ChangeScreenIndexState>(
            builder: (context, state) {
              return screens[state.index];
            },
          ),
        ));
  }

  showSnackbar() {
    Get.snackbar(
      'Logged Out',
      "You have been Logged Out from Developers Account",
      backgroundColor: Theme.of(context).colorScheme.background,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      colorText: Theme.of(context).colorScheme.onSurface,
    );
  }
}
