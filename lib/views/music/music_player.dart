// ... (your imports remain the same)

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_app_using_bloc/views/music/playerControllerStates.dart';
import 'package:pulsator/pulsator.dart';

import '../../bloc/play_song_bloc/play_song_bloc.dart';
import '../Utils/google_ads/baner_ads_helper.dart';
import '../Utils/utils.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  PlayerController playerController = Get.find<PlayerController>();

  @override
  void initState() {
    super.initState();
    initializeDarePageBanner();
  }

  void initializeDarePageBanner() async {
    playerBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.playerScreen(),
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
    await playerBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    setState(() {});

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: BlocBuilder<PlaySongBloc, PlaySongState>(
              builder: (context, state) {
                playerController.playSongIndex.value ??= state.songIndex;
                playerController.allSongs = state.songsList.obs;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 240.0,
                      height: 240.0,
                      child: Obx(
                        () => Pulsator(
                          style: PulseStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          count: 5,
                          duration: const Duration(seconds: 4),
                          repeat: 0,
                          startFromScratch: false,
                          autoStart: playerController.isPlay.value,
                          fit: PulseFit.cover,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: theme.brightness == Brightness.dark
                                  ? AppShadows.blackThemeShadow
                                  : AppShadows.blackThemeShadow,
                            ),
                            child: CircleAvatar(
                              radius: 120.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              child: const CircleAvatar(
                                radius: 115.0,
                                backgroundImage:
                                    AssetImage('assets/hear_music.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      state.currentSong == null
                          ? 'Music Player'
                          : playerController.allSongs.isNotEmpty
                              ? playerController
                                          .allSongs[playerController
                                              .playSongIndex.value!]!
                                          .fileName!
                                          .length >
                                      30
                                  ? ('${playerController.allSongs[playerController.playSongIndex.value!]!.fileName!.substring(0, 30)} ...')
                                  : playerController
                                      .allSongs[playerController
                                          .playSongIndex.value!]!
                                      .fileName!
                              : '',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder<Duration>(
                              stream: playerController
                                  .audioPlayer.onPositionChanged,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final currentPosition =
                                      snapshot.data as Duration;
                                  return Text(
                                    playerController.formatDuration(
                                      duration: currentPosition,
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    child: Text(
                                      playerController.formatDuration(
                                        duration: Duration.zero,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            Text(
                              playerController.formatDuration(
                                duration:
                                    playerController.overAllDuration.value ??
                                        Duration.zero,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Stack(
                          children: [
                            StreamBuilder<Duration>(
                              stream: playerController
                                  .audioPlayer.onPositionChanged,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final currentPosition =
                                      snapshot.data as Duration;
                                  return LinearProgressIndicator(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(10),
                                    value: currentPosition.inMilliseconds /
                                        (playerController.overAllDuration.value
                                                ?.inMilliseconds ??
                                            1),
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    minHeight: 10,
                                  );
                                } else {
                                  return LinearProgressIndicator(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(10),
                                    value: 0.0,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    minHeight: 10,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: theme.brightness == Brightness.dark
                                  ? AppShadows.blackThemeShadow
                                  : AppShadows.blackThemeShadow,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                if (state.songsList.isEmpty) {
                                  return;
                                }

                                if (playerController.playSongIndex.value! > 0) {
                                  playerController.playSongIndex.value =
                                      (playerController.playSongIndex.value!) -
                                          1;

                                  context.read<PlaySongBloc>().add(
                                        ChoosedSongChoosedModePlaySong(
                                          choosedSongIndex: playerController
                                              .playSongIndex.value!,
                                          currentSong:
                                              playerController.allSongs[
                                                  playerController
                                                      .playSongIndex.value!]!,
                                          isPlaying: true,
                                          choosedModeIndex: state.modeName,
                                        ),
                                      );

                                  playerController.playAudio(
                                    playerController
                                        .allSongs[playerController
                                            .playSongIndex.value!]!
                                        .file!,
                                  );

                                  context.read<PlaySongBloc>().add(
                                        ChangeSongIndexPlaySong(
                                          changeCurrentSongIndex:
                                              playerController
                                                  .playSongIndex.value!,
                                        ),
                                      );
                                } else {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      snackStyle: SnackStyle.GROUNDED,
                                      duration: const Duration(seconds: 1),
                                      snackPosition: SnackPosition.TOP,
                                      messageText: Text(
                                        'No Previous Songs'.capitalize!,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                      titleText: Text(
                                        'Attention 😒😒',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 30.r,
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                child: Icon(
                                  Icons.skip_previous,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: theme.brightness == Brightness.dark
                                ? AppShadows.blackThemeShadow
                                : AppShadows.blackThemeShadow,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              if (state.songsList.isEmpty) {
                                return;
                              }

                              if (playerController.audioPlayer.state ==
                                  PlayerState.playing) {
                                playerController.pauseAudio();

                                context.read<PlaySongBloc>().add(
                                      const ChangePlayingStatePlaySong(
                                        isPlay: false,
                                      ),
                                    );
                              } else {
                                if (state.currentSong != null) {
                                  playerController.playAudio(
                                    playerController
                                        .allSongs[playerController
                                            .playSongIndex.value!]!
                                        .file!,
                                  );
                                }
                                context.read<PlaySongBloc>().add(
                                      const ChangePlayingStatePlaySong(
                                        isPlay: true,
                                      ),
                                    );
                              }
                            },
                            child: CircleAvatar(
                              radius: 40.r,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: StreamBuilder(
                                stream: playerController
                                    .audioPlayer.onPlayerStateChanged,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final playerState =
                                        snapshot.data as PlayerState;

                                    return playerState == PlayerState.playing
                                        ? Icon(
                                            Icons.pause,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          )
                                        : playerState == PlayerState.paused
                                            ? Icon(
                                                Icons.play_arrow,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.white),
                                              );
                                  } else {
                                    return state.isPlaying == true &&
                                            playerController
                                                    .audioPlayer.state !=
                                                PlayerState.playing
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.white),
                                          )
                                        : Icon(
                                            Icons.play_arrow,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: theme.brightness == Brightness.dark
                                  ? AppShadows.blackThemeShadow
                                  : AppShadows.blackThemeShadow,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                if (state.songsList.isEmpty) {
                                  return;
                                }

                                if (playerController.playSongIndex.value !=
                                        null &&
                                    playerController.playSongIndex.value! <
                                        (state.songsList.length - 1)) {
                                  playerController.playSongIndex.value =
                                      (playerController.playSongIndex.value!) +
                                          1;

                                  context.read<PlaySongBloc>().add(
                                        ChoosedSongChoosedModePlaySong(
                                          choosedSongIndex: playerController
                                              .playSongIndex.value!,
                                          currentSong:
                                              playerController.allSongs[
                                                  playerController
                                                      .playSongIndex.value!]!,
                                          isPlaying: true,
                                          choosedModeIndex: state.modeName,
                                        ),
                                      );

                                  // playerController.stopAudio();

                                  playerController.playAudio(
                                    playerController
                                        .allSongs[playerController
                                            .playSongIndex.value!]!
                                        .file!,
                                  );

                                  context.read<PlaySongBloc>().add(
                                        ChangeSongIndexPlaySong(
                                          changeCurrentSongIndex:
                                              playerController
                                                  .playSongIndex.value!,
                                        ),
                                      );
                                } else {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      snackStyle: SnackStyle.GROUNDED,
                                      duration: const Duration(seconds: 1),
                                      snackPosition: SnackPosition.TOP,
                                      messageText: Text(
                                        'No Next Data'.capitalize!,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                      titleText: Text(
                                        'Attention 😒😒'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 30.r,
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                child: Icon(
                                  Icons.skip_next,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: playerBanner.size.height.toDouble(),
        width: playerBanner.size.width.toDouble(),
        child: AdWidget(ad: playerBanner),
      ),
    );
  }

  late BannerAd playerBanner;
}
