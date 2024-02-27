import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_app_using_bloc/bloc/play_song_bloc/play_song_bloc.dart';
import 'package:music_app_using_bloc/models/models.dart';
import 'package:music_app_using_bloc/views/Utils/utils.dart';
import '../../models/music_model.dart';
import '../Utils/google_ads/baner_ads_helper.dart';
import '../views.dart';

class MusicLibrary extends StatefulWidget {
  final MusicModel? folders;
  const MusicLibrary({super.key, required this.folders});

  @override
  State<MusicLibrary> createState() => _MusicLibraryState();

  List<SongModel> convertToSongModelList(List<Map<String, dynamic>> songList) {
    return songList.map((json) => SongModel.fromJson(json)).toList();
  }
}

class _MusicLibraryState extends State<MusicLibrary> {
  @override
  void initState() {
    super.initState();
    initializeDarePageBanner();
  }

  void initializeDarePageBanner() async {
    libraryBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.libraryScreen(),
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
    await libraryBanner.load();
  }

  late BannerAd libraryBanner;
  @override
  Widget build(BuildContext context) {
    log(widget.folders.toString());
    ThemeData theme = Theme.of(context);

    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: libraryBanner.size.height.toDouble(),
          width: libraryBanner.size.width.toDouble(),
          child: AdWidget(ad: libraryBanner),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot<Map<String, dynamic>> musicSnapshot =
                  snapshot.data as DocumentSnapshot<Map<String, dynamic>>;

              if (musicSnapshot.exists) {
                Map<String, dynamic> data = musicSnapshot.data()!;

                List<SongModel> instrumentalSongs = [];
                List<SongModel> ambientsSongs = [];
                List<SongModel> natureSongs = [];
                List<SongModel> traditionalSongs = [];
                List<SongModel> guidedSongs = [];
                List<SongModel> binauralSongs = [];
                List<SongModel> chantsSongs = [];
                List<SongModel> mindfulnessSongs = [];
                List<SongModel> yogaSongs = [];
                List<SongModel> solfeggioSongs = [];
                List<SongModel> gentleSongs = [];
                List<SongModel> peacefullSongs = [];
                List<SongModel> sunriseSongs = [];
                List<SongModel> softSongs = [];
                List<SongModel> heavenSongs = [];

                // ~ Check if 'ambients' key exists and has the correct type
                if (data['ambients'] is List<dynamic>) {
                  for (dynamic songData in data['ambients']) {
                    if (songData is Map<String, dynamic>) {
                      ambientsSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'instrumental' key exists and has the correct type
                if (data['instrumental'] is List<dynamic>) {
                  for (dynamic songData in data['instrumental']) {
                    if (songData is Map<String, dynamic>) {
                      instrumentalSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'nature' key exists and has the correct type
                if (data['nature'] is List<dynamic>) {
                  for (dynamic songData in data['nature']) {
                    if (songData is Map<String, dynamic>) {
                      natureSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'traditional' key exists and has the correct type
                if (data['traditional'] is List<dynamic>) {
                  for (dynamic songData in data['traditional']) {
                    if (songData is Map<String, dynamic>) {
                      traditionalSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'traditional' key exists and has the correct type
                if (data['guided'] is List<dynamic>) {
                  for (dynamic songData in data['guided']) {
                    if (songData is Map<String, dynamic>) {
                      guidedSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'binaural' key exists and has the correct type
                if (data['binaural'] is List<dynamic>) {
                  for (dynamic songData in data['binaural']) {
                    if (songData is Map<String, dynamic>) {
                      binauralSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'chants' key exists and has the correct type
                if (data['chants'] is List<dynamic>) {
                  for (dynamic songData in data['chants']) {
                    if (songData is Map<String, dynamic>) {
                      chantsSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

// ~ Check if 'mindfulness' key exists and has the correct type
                if (data['mindfulness'] is List<dynamic>) {
                  for (dynamic songData in data['mindfulness']) {
                    if (songData is Map<String, dynamic>) {
                      mindfulnessSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'yoga' key exists and has the correct type
                if (data['yoga'] is List<dynamic>) {
                  for (dynamic songData in data['yoga']) {
                    if (songData is Map<String, dynamic>) {
                      yogaSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'solfeggio' key exists and has the correct type
                if (data['solfeggio'] is List<dynamic>) {
                  for (dynamic songData in data['solfeggio']) {
                    if (songData is Map<String, dynamic>) {
                      solfeggioSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'gentle' key exists and has the correct type
                if (data['gentle'] is List<dynamic>) {
                  for (dynamic songData in data['gentle']) {
                    if (songData is Map<String, dynamic>) {
                      gentleSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'peacefull' key exists and has the correct type
                if (data['peacefull'] is List<dynamic>) {
                  for (dynamic songData in data['peacefull']) {
                    if (songData is Map<String, dynamic>) {
                      peacefullSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'sunrise' key exists and has the correct type
                if (data['sunrise'] is List<dynamic>) {
                  for (dynamic songData in data['sunrise']) {
                    if (songData is Map<String, dynamic>) {
                      sunriseSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'sunrise' key exists and has the correct type
                if (data['soft'] is List<dynamic>) {
                  for (dynamic songData in data['soft']) {
                    if (songData is Map<String, dynamic>) {
                      softSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }

                // ~ Check if 'heaven' key exists and has the correct type
                if (data['heaven'] is List<dynamic>) {
                  for (dynamic songData in data['heaven']) {
                    if (songData is Map<String, dynamic>) {
                      heavenSongs.add(SongModel.fromJson(songData));
                    }
                  }
                }
                // Repeat the above process for other lists...

                return CupertinoScrollbar(
                  scrollbarOrientation: ScrollbarOrientation.right,
                  thickness: 6.0,
                  thicknessWhileDragging: 12.0,
                  radius: const Radius.circular(40),
                  radiusWhileDragging: const Radius.circular(40),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    children: [
                      musciFolder(
                        index: 1,
                        theme: theme,
                        name: "ambients",
                        songList: ambientsSongs,
                      ),
                      musciFolder(
                        index: 2,
                        theme: theme,
                        name: "nature",
                        songList: natureSongs,
                      ),
                      musciFolder(
                        index: 3,
                        theme: theme,
                        name: "traditional",
                        songList: traditionalSongs,
                      ),
                      musciFolder(
                        index: 4,
                        theme: theme,
                        name: "binaural",
                        songList: binauralSongs,
                      ),
                      musciFolder(
                        index: 5,
                        theme: theme,
                        name: "chants",
                        songList: chantsSongs,
                      ),
                      musciFolder(
                        index: 6,
                        theme: theme,
                        name: "mindfulness",
                        songList: mindfulnessSongs,
                      ),
                      musciFolder(
                        index: 7,
                        theme: theme,
                        name: "yoga",
                        songList: yogaSongs,
                      ),
                      musciFolder(
                        index: 8,
                        theme: theme,
                        name: "solfeggio",
                        songList: solfeggioSongs,
                      ),
                      musciFolder(
                        index: 8,
                        theme: theme,
                        name: "gentle",
                        songList: gentleSongs,
                      ),
                      musciFolder(
                        index: 10,
                        theme: theme,
                        name: "peacefull",
                        songList: peacefullSongs,
                      ),
                      musciFolder(
                        index: 11,
                        theme: theme,
                        name: "sunrise",
                        songList: sunriseSongs,
                      ),
                      musciFolder(
                        index: 12,
                        theme: theme,
                        name: "soft",
                        songList: softSongs,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("Netwrok Issue"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              );
            }
          },
        ));
  }

  Widget musciFolder({
    required List<SongModel> songList,
    required ThemeData theme,
    required int index,
    required String name,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: InkWell(
        onTap: () {
          context.read<PlaySongBloc>().add(
                ChoosedModePlaySong(choosedModeIndex: name, songList: songList),
              );
          Get.to(() => ModeSongs(
                modeName: name,
                songList: songList,
                musicFolders: widget.folders,
              ));
        },
        child: Container(
            margin: EdgeInsets.only(
              bottom: 15.h,
            ),
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.r)),
            child: BlocBuilder<PlaySongBloc, PlaySongState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        (index).toString(),
                        style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppShadows.blackThemeShadow
                                    : AppShadows.blackThemeShadow),
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          child: Icon(
                            Icons.folder,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Center(
                      child: Text(
                        name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1),
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
