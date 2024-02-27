// ignore_for_file: avoid_print, file_names

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '../../models/models.dart';

class PlayerController extends GetxController {
  Rx<Duration?> lastPosition = Rx<Duration?>(null);
  Rx<Duration?> overAllDuration = Rx<Duration?>(null);

  RxList<SongModel?> allSongs = <SongModel?>[].obs;

  Rx<int?> playSongIndex = 0.obs;

  var isPlay = false.obs;

  late AudioPlayer _audioPlayer;

  PlayerController() {
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPositionChanged.listen((event) {
      // lastPosition.value = event;
    });

    // Listen for player state changes
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        // Perform your desired action when audio playback is complete
        // For example, you can update the UI, play the next song, etc.
        if (playSongIndex.value! < allSongs.length) {
          playSongIndex.value = playSongIndex.value! + 1;

          playAudio(allSongs[playSongIndex.value!]!.file!);
        }
        print('Audio playback completed!');
        // Add your custom logic here
      }
    });
  }

  // ~ Play Audio
  Future<void> playAudio(String audioUrl) async {
    await _audioPlayer.stop(); // Stop any currently playing audio
    isPlay.value = false;
    if (lastPosition.value != null) {
      await _audioPlayer.seek(lastPosition.value!);
    }

    await _audioPlayer.play(UrlSource(audioUrl));
    isPlay.value = true;

    overAllDuration.value = await _audioPlayer.getDuration();
  }

  Future<void> pauseAudio() async {
    _audioPlayer.pause();
    isPlay.value = false;

    lastPosition.value = await _audioPlayer.getCurrentPosition();
  }

  Future<void> stopAudio() async {
    if (_audioPlayer.state == PlayerState.playing ||
        _audioPlayer.state == PlayerState.paused) {
      await _audioPlayer.stop();
      isPlay.value = false;

      lastPosition.value = Duration.zero;
      playSongIndex.value = 0; // Reset playSongIndex
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  AudioPlayer get audioPlayer => _audioPlayer;

  var isLoading = true.obs;

  String formatDuration({required Duration duration}) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
