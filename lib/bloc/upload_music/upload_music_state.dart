// ignore_for_file: must_be_immutable

part of 'upload_music_bloc.dart';

class UploadMusicState extends Equatable {
  final File? file;
  final String? fileName;
  final bool? isLoading;

  const UploadMusicState({this.file, this.isLoading = false, this.fileName});

  UploadMusicState copyWith({File? file, bool? isLoading, String? fileName}) {
    return UploadMusicState(
        file: file, isLoading: isLoading ?? this.isLoading, fileName: fileName);
  }

  @override
  List<Object?> get props => [file, isLoading, fileName];
}
