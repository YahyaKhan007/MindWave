class MusicModel {
  List<Map<String, dynamic>> instrumental;
  List<Map<String, dynamic>> ambients;
  List<Map<String, dynamic>> nature;
  List<Map<String, dynamic>> traditional;
  List<Map<String, dynamic>> guided;
  List<Map<String, dynamic>> binaural;
  List<Map<String, dynamic>> chants;
  List<Map<String, dynamic>> mindfulness;
  List<Map<String, dynamic>> yoga;
  List<Map<String, dynamic>> solfeggio;
  List<Map<String, dynamic>> gentle;
  List<Map<String, dynamic>> peacefull;
  List<Map<String, dynamic>> sunrise;
  List<Map<String, dynamic>> soft;
  List<Map<String, dynamic>> heaven;

  MusicModel({
    required this.instrumental,
    required this.ambients,
    required this.nature,
    required this.traditional,
    required this.guided,
    required this.binaural,
    required this.chants,
    required this.mindfulness,
    required this.yoga,
    required this.solfeggio,
    required this.gentle,
    required this.peacefull,
    required this.sunrise,
    required this.soft,
    required this.heaven,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      instrumental: List<Map<String, dynamic>>.from(json['instrumental'] ?? []),
      ambients: List<Map<String, dynamic>>.from(json['ambients'] ?? []),
      nature: List<Map<String, dynamic>>.from(json['nature'] ?? []),
      traditional: List<Map<String, dynamic>>.from(json['traditional'] ?? []),
      guided: List<Map<String, dynamic>>.from(json['guided'] ?? []),
      binaural: List<Map<String, dynamic>>.from(json['binaural'] ?? []),
      chants: List<Map<String, dynamic>>.from(json['chants'] ?? []),
      mindfulness: List<Map<String, dynamic>>.from(json['mindfulness'] ?? []),
      yoga: List<Map<String, dynamic>>.from(json['yoga'] ?? []),
      solfeggio: List<Map<String, dynamic>>.from(json['solfeggio'] ?? []),
      gentle: List<Map<String, dynamic>>.from(json['gentle'] ?? []),
      peacefull: List<Map<String, dynamic>>.from(json['peacefull'] ?? []),
      sunrise: List<Map<String, dynamic>>.from(json['sunrise'] ?? []),
      soft: List<Map<String, dynamic>>.from(json['soft'] ?? []),
      heaven: List<Map<String, dynamic>>.from(json['heaven'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instrumental': instrumental,
      'ambients': ambients,
      'nature': nature,
      'traditional': traditional,
      'guided': guided,
      'binaural': binaural,
      'chants': chants,
      'mindfulness': mindfulness,
      'yoga': yoga,
      'solfeggio': solfeggio,
      'gentle': gentle,
      'peacefull': peacefull,
      'sunrise': sunrise,
      'soft': soft,
      'heaven': heaven,
    };
  }
}
