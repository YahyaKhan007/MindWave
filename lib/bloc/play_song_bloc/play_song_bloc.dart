// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'play_song_event.dart';
part 'play_song_state.dart';

class PlaySongBloc extends Bloc<PlaySongEvent, PlaySongState> {
  PlaySongBloc() : super(const PlaySongState(songsList: [])) {
    on<ChoosedModePlaySong>(_choosedModeSong);
    on<ChoosedSongChoosedModePlaySong>(_playSongs);
    on<ChangeSongIndexPlaySong>(_changeCurrentSongIndex);
    on<ChangePlayingStatePlaySong>(_changeCurrentSongPlayState);
  }

  void _choosedModeSong(
      ChoosedModePlaySong event, Emitter<PlaySongState> emitter) {
    log(event.choosedModeIndex);

    emit(state.copyWith(
        modeName: event.choosedModeIndex, songsList: event.songList));
  }

  void _playSongs(
      ChoosedSongChoosedModePlaySong event, Emitter<PlaySongState> emitter) {
    // log("index no is ${event.choosedSongIndex.toString()}");

    log("\n\n\n\t\t\t\t From Event\n\n\n");
    log("Sog to be Playing  === >   ${event.currentSong.fileName!.substring(0, 50)}");

    emit(state.copyWith(
      isPlaying: true,
      modeName: event.choosedModeIndex,
      songIndex: event.choosedSongIndex,
      currentSong: event.currentSong,
    ));

    log("\n\n\n\t\t\t\t From state\n\n\n");
    log("Sog to be Playing  === >   ${state.currentSong!.fileName!.substring(0, 20)}");

    // log(event.choosedSongIndex.toString());
    // log(isPlay.toString());
  }

  // ~ _changeCurrentSongIndex
  void _changeCurrentSongIndex(
      ChangeSongIndexPlaySong event, Emitter<PlaySongState> emitter) {
    emit(
      state.copyWith(songIndex: event.changeCurrentSongIndex),
    );
  }

  // ~ _changeCurrentSongPlayState
  void _changeCurrentSongPlayState(
      ChangePlayingStatePlaySong event, Emitter<PlaySongState> emitter) {
    emit(
      state.copyWith(isPlaying: event.isPlay),
    );
  }
}
