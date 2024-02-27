class SongModel {
  String? fileName;
  String? file;

  SongModel({
    required this.fileName,
    required this.file,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      fileName: json["fileName"],
      file: json["file"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'file': file,
    };
  }
}
