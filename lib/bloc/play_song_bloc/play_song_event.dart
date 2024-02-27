part of 'play_song_bloc.dart';

sealed class PlaySongEvent extends Equatable {
  const PlaySongEvent();

  @override
  List<Object> get props => [];
}

class ChoosedModePlaySong extends PlaySongEvent {
  final String choosedModeIndex;
  final List<SongModel> songList;

  const ChoosedModePlaySong(
      {required this.choosedModeIndex, required this.songList});

  @override
  List<Object> get props => [choosedModeIndex, songList];
}

class ChoosedSongChoosedModePlaySong extends PlaySongEvent {
  final int choosedSongIndex;
  final SongModel currentSong;
  final bool isPlaying;
  final String choosedModeIndex;

  const ChoosedSongChoosedModePlaySong({
    required this.choosedSongIndex,
    required this.currentSong,
    required this.isPlaying,
    required this.choosedModeIndex,
  });

  @override
  List<Object> get props => [
        choosedSongIndex,
        currentSong,
        isPlaying,
        choosedModeIndex,
      ];
}

class ChangeSongIndexPlaySong extends PlaySongEvent {
  final int changeCurrentSongIndex;

  const ChangeSongIndexPlaySong({required this.changeCurrentSongIndex});

  @override
  List<Object> get props => [changeCurrentSongIndex];
}

class ChangePlayingStatePlaySong extends PlaySongEvent {
  final bool isPlay;

  const ChangePlayingStatePlaySong({required this.isPlay});

  @override
  List<Object> get props => [isPlay];
}
