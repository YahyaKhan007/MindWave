part of 'upload_music_bloc.dart';

sealed class UploadMusicEvent extends Equatable {
  const UploadMusicEvent();

  @override
  List<Object> get props => [];
}

class MusicPickerEvent extends UploadMusicEvent {}

class ResetMusicPickerEvent extends UploadMusicEvent {}

class MusicUploading extends UploadMusicEvent {
  final bool isLoading;
  final File choosedFile;
  final String choosedFileName;
  final String folderName;
  final MusicModel musicModel;

  const MusicUploading({
    required this.musicModel,
    required this.choosedFile,
    required this.folderName,
    required this.isLoading,
    required this.choosedFileName,
  });
  @override
  List<Object> get props =>
      [isLoading, choosedFile, folderName, choosedFileName, musicModel];
}

class MusicUploaded extends UploadMusicEvent {
  final bool isLoading;

  const MusicUploaded({required this.isLoading});
  @override
  List<Object> get props => [isLoading];
}
