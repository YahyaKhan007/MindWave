// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app_using_bloc/views/upload_music_to_server/upload_status.dart';
import 'package:music_app_using_bloc/models/models.dart';
import 'package:music_app_using_bloc/models/music_model.dart';
import 'package:music_app_using_bloc/views/Utils/upload_to_firestore_utils.dart';

import '../../views/Utils/utils.dart';

part 'upload_music_event.dart';
part 'upload_music_state.dart';

class UploadMusicBloc extends Bloc<UploadMusicEvent, UploadMusicState> {
  final AudioPickerUtils _audioPicker;

  UploadMusicBloc(this._audioPicker) : super(const UploadMusicState()) {
    on<MusicPickerEvent>(_musicPickerEvent);
    on<MusicUploading>(_musicUploading);
    on<MusicUploaded>(_musicUploaded);
    on<ResetMusicPickerEvent>(_resetMusicPickerEvent);
  }

// ~ Reset file to null methode
  void _resetMusicPickerEvent(
      ResetMusicPickerEvent event, Emitter<UploadMusicState> emitter) async {
    emit(state.copyWith(
      file: null,
      fileName: null,
    ));
  }

// ~ Music Picker Event

  void _musicPickerEvent(
      MusicPickerEvent event, Emitter<UploadMusicState> emitter) async {
    List<dynamic>? pickedAudio = await _audioPicker.pickAudio();

    if (pickedAudio != null) {
      try {
        final File file = pickedAudio[0];
        final String fileName = pickedAudio[1];

        emit(state.copyWith(file: file, fileName: fileName));
      } catch (e) {
        log("\n\n\n\t\t\t\t\t\t=================>\n\n\n\n\n\t\t\t\t\t${e.toString()}\n\n\n\n\t\t\t\t\t\t===============>\n\n\n\n\n\n");
      }
    }
  }

// ~ Music is uploading event

  void _musicUploading(
      MusicUploading event, Emitter<UploadMusicState> emitter) async {
    emit(state.copyWith(isLoading: true));
    log("Trying to upload");

    final MusicUplaodFirebaseUtils uploadUtils = MusicUplaodFirebaseUtils();
    var controller = Get.put(UploadStatus());

    SimpleDialog dialog = SimpleDialog(
      title: const Text("Upload Progress"),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        Column(
          children: [
            const CircularProgressIndicator(
              color: Colors.blue,
            ),
            SizedBox(
              height: 15.h,
            ),
            Obx(() {
              return Text(
                "Upload Progress: ${(controller.progressValue.value * 100).toStringAsFixed(2)}%",
              );
            }),
            const SizedBox(height: 16.0),
            CircularProgressIndicator(
              value: controller.progressValue.value,
            ),
          ],
        ),
      ],
    );

    Get.dialog(dialog, barrierDismissible: false);

    // ^ Upload the audio file to Firebase Storage
    String? downloadUrl = await uploadUtils.uploadAudioFile(
      audioFile: event.choosedFile,
      fileName: event.choosedFileName,
      onProgress: (double uploadStatus) {
        controller.progressValue.value = uploadStatus;
      },
    );

    log("Uploaded Successfully");

    if (downloadUrl != null) {
      log("Audio file uploaded successfully. Download URL: $downloadUrl");

      SongModel songModel =
          SongModel(fileName: event.choosedFileName, file: downloadUrl);

      switch (event.folderName) {
        case 'instrumental':
          event.musicModel.instrumental.add(songModel.toJson());
          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'ambients':
          event.musicModel.ambients.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'nature':
          event.musicModel.nature.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'traditional':
          event.musicModel.traditional.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'guided':
          event.musicModel.guided.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'binaural':
          event.musicModel.binaural.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'chants':
          event.musicModel.chants.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'mindfulness':
          event.musicModel.mindfulness.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'yoga':
          event.musicModel.yoga.add(songModel.toJson());
          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'solfeggio':
          event.musicModel.solfeggio.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'gentle':
          event.musicModel.gentle.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'peacefull':
          event.musicModel.peacefull.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'sunrise':
          event.musicModel.sunrise.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'soft':
          event.musicModel.soft.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;
        case 'heaven':
          event.musicModel.heaven.add(songModel.toJson());

          await FirebaseFirestore.instance
              .collection('music')
              .doc('8susjltyDBVV299DHHC3d1lVt5w1')
              .set(event.musicModel.toJson());

          emit(state.copyWith(file: null, fileName: null, isLoading: false));
          Get.back();
          break;

        default:
          Get.snackbar(
            "Uploaded",
            "Done with the uploading music",
            colorText: Colors.white,
            backgroundColor: Colors.white24,
          );
          break;
      }

      // event.

      // Update the state or perform other actions as needed
      // emit(state.copyWith(file: null, fileName: null, isLoading: false));
    } else {
      // Handle the case where the upload failed
      emit(state.copyWith(isLoading: false));
      log("Failed to upload audio file");
    }

    // emit(state.copyWith(isLoading: event.isLoading));
  }

// ~ Music is uploaded event

  void _musicUploaded(MusicUploaded event, Emitter<UploadMusicState> emitter) {
    // emit(state.copyWith(isLoading: event.isLoading));
  }
}
