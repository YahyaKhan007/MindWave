// ignore_for_file: must_be_immutable

part of 'play_song_bloc.dart';

class PlaySongState extends Equatable {
  final int songIndex;
  final String modeName;
  final List<SongModel> songsList;
  final SongModel? currentSong;
  final bool isPlaying;

  const PlaySongState({
    required this.songsList,
    this.songIndex = 0,
    this.modeName = '',
    this.isPlaying = false,
    this.currentSong,
  });

  PlaySongState copyWith(
      {int? songIndex,
      String? modeName,
      bool? isPlaying,
      SongModel? currentSong,
      List<SongModel>? songsList}) {
    log("inside the state ---->  ${this.currentSong?.fileName.toString()}");
    return PlaySongState(
        songIndex: songIndex ?? this.songIndex,
        modeName: modeName ?? this.modeName,
        songsList: songsList ?? this.songsList,
        currentSong: currentSong ?? this.currentSong,
        isPlaying: isPlaying ?? this.isPlaying);
  }

  @override
  List<Object?> get props =>
      [songIndex, modeName, isPlaying, songsList, currentSong];
}
