part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LightTheme extends ThemeEvent {}

class DarkTheme extends ThemeEvent {}

class InitTheme extends ThemeEvent {}
