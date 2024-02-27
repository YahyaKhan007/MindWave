part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode, required this.themeData});

  ThemeState copyWith({ThemeData? themeData, ThemeMode? themeMode}) {
    return ThemeState(
        themeData: themeData ?? this.themeData,
        themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object> get props => [themeData, themeMode];
}
