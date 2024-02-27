import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_app_using_bloc/views/music/playerControllerStates.dart';

import '../../bloc/change_screen_index/change_screen_index_bloc.dart';
import '../../bloc/play_song_bloc/play_song_bloc.dart';
import '../../models/models.dart';
import '../../models/music_model.dart';
import '../Utils/google_ads/baner_ads_helper.dart';
import '../Utils/utils.dart';
import '../views.dart';

class ModeSongs extends StatefulWidget {
  final List<SongModel> songList;
  final MusicModel? musicFolders;
  final String modeName;

  const ModeSongs(
      {super.key,
      required this.musicFolders,
      required this.songList,
      required this.modeName});

  @override
  State<ModeSongs> createState() => _ModeSongsState();
}

class _ModeSongsState extends State<ModeSongs> {
  @override
  void initState() {
    super.initState();
    initializeDarePageBanner();
  }

  void initializeDarePageBanner() async {
    musicBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.musicScreen(),
      listener: BannerAdListener(
          onAdLoaded: (ad) {},
          onAdClosed: (ad) {
            ad.dispose();
          },
          onAdFailedToLoad: (ad, err) {
            log(err.toString());
          }),
      request: const AdRequest(),
    );
    await musicBanner.load();
  }

  late BannerAd musicBanner;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: musicBanner.size.height.toDouble(),
        width: musicBanner.size.width.toDouble(),
        child: AdWidget(ad: musicBanner),
      ),
      // backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.surface,
        toolbarHeight: 60.h,
        centerTitle: true,
        title: BlocBuilder<PlaySongBloc, PlaySongState>(
          builder: (context, state) {
            return Text(
              state.modeName.toUpperCase().toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  letterSpacing: -1),
            );
          },
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: theme.brightness == Brightness.dark
                  ? AppShadows.blackThemeShadow
                  : AppShadows.lightThemeShadow),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.surface,
              child: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.onSurface,
                size: 20.r,
              ),
            ),
          ),
        ),
        actions: [
          Visibility(
            visible: FirebaseAuth.instance.currentUser != null ? true : false,
            child: BlocBuilder<PlaySongBloc, PlaySongState>(
              builder: (context, state) {
                return Container(
                    padding: EdgeInsets.only(right: 12.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppShadows.blackThemeShadow
                                : AppShadows.lightThemeShadow),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () {
                        log(FirebaseAuth.instance.currentUser.toString());
                        //  != null
                        //     ? "true"
                        //     : "false");
                        Get.to(() => UploadMusicToServer(
                              musicFoldr: widget.musicFolders!,
                              folderName: state.modeName,
                            ));
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: Icon(
                          CupertinoIcons.cloud_upload,
                          size: 20.r,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ));
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<PlaySongBloc, PlaySongState>(builder: (context, state) {
        return state.songsList.isEmpty
            ? Center(
                child: Container(
                  height: 70.h,
                  margin: EdgeInsets.symmetric(horizontal: 50.w),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: theme.colorScheme.surface,
                      boxShadow: theme.brightness == Brightness.dark
                          ? AppShadows.blackThemeShadow
                          : AppShadows.lightThemeShadow),
                  child: Center(
                    child: Text(
                      "There are no songs yet",
                      style: TextStyle(
                          color: theme.colorScheme.onSurface, fontSize: 13.sp),
                    ),
                  ),
                ),
              )
            : CupertinoScrollbar(
                scrollbarOrientation: ScrollbarOrientation.right,
                thickness: 6.0,
                thicknessWhileDragging: 12.0,
                radius: const Radius.circular(40),
                radiusWhileDragging: const Radius.circular(40),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: widget.songList.length,
                  itemBuilder: (context, index) {
                    SongModel currentSong = state.songsList[index];
                    return Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 10.w),
                      child: InkWell(
                        onTap: () {
                          context.read<PlaySongBloc>().add(
                                ChoosedSongChoosedModePlaySong(
                                  choosedModeIndex: state.modeName,
                                  isPlaying: true,
                                  choosedSongIndex: index,
                                  currentSong: currentSong,
                                ),
                              );
                          context.read<PlaySongBloc>().add(
                                ChoosedSongChoosedModePlaySong(
                                  choosedModeIndex: state.modeName,
                                  isPlaying: true,
                                  choosedSongIndex: index,
                                  currentSong: currentSong,
                                ),
                              );

                          context
                              .read<ChangeScreenIndexBloc>()
                              .add(const NextPageIndecChangeScreen(index: 1));

                          var controler = Get.find<PlayerController>();
                          controler.playSongIndex.value = index;

                          // ~  if already playing a file
                          if (controler.audioPlayer.state ==
                                  PlayerState.playing ||
                              controler.audioPlayer.state ==
                                  PlayerState.paused) {
                            controler.stopAudio();
                          }

                          controler.playAudio(currentSong.file!);

                          Get.off(() =>
                              HomeScreen(musicModel: widget.musicFolders));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: index == state.songIndex
                                  ? theme.colorScheme.background
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15.r)),
                          margin: EdgeInsets.only(
                            bottom: 20.h,
                          ),
                          child: BlocBuilder<PlaySongBloc, PlaySongState>(
                            builder: (context, state) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? AppShadows.blackThemeShadow
                                                : AppShadows.blackThemeShadow),
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: index == state.songIndex
                                          //  &&
                                          // state.isPlaying
                                          ? theme.colorScheme.secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      child: index == state.songIndex &&
                                              state.isPlaying == true
                                          ? Icon(
                                              Icons.pause,
                                              color:
                                                  theme.colorScheme.onSecondary,
                                            )
                                          : Icon(
                                              Icons.play_arrow,
                                              color:
                                                  theme.colorScheme.onSurface,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    widget.songList[index].fileName!.length > 25
                                        ? ('${widget.songList[index].fileName!.substring(0, 20)}...')
                                        : widget.songList[index].fileName!,
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -1),
                                  ),
                                  Text(
                                    state.modeName,
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
      }),
    );
  }
}
