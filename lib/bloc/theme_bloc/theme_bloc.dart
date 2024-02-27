// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static ThemeData lightTheme = ThemeData.light();
  static ThemeData darkTheme = ThemeData.dark();
  // late Box _themeBox;

  ThemeBloc()
      : super(ThemeState(themeData: lightTheme, themeMode: ThemeMode.light)) {
    on<LightTheme>(_lightTheme);
    on<DarkTheme>(_darkTheme);
    on<InitTheme>(_initTheme);
  }

  // ~ Init theme
  void _initTheme(InitTheme event, Emitter<ThemeState> emitter) async {
    ThemeMode savedThemeMode = await _getSavedThemePreference();
    ThemeData initialTheme =
        savedThemeMode == ThemeMode.light ? lightTheme : darkTheme;

    emit(ThemeState(themeData: initialTheme, themeMode: savedThemeMode));
  }

// ^ Getting Previous theme record
  Future<ThemeMode> _getSavedThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('themePreference');
    return themeIndex != null ? ThemeMode.values[themeIndex] : ThemeMode.light;
  }

// ^ Saved Previous theme record

  void _saveThemePreference(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themePreference', themeMode.index);
  }

// ~ Light theme
  void _lightTheme(LightTheme event, Emitter<ThemeState> emitter) {
    log('Light theme event triggered');
    ThemeMode newThemeMode =
        lightTheme == lightTheme ? ThemeMode.light : ThemeMode.dark;

    emit(state.copyWith(themeData: lightTheme, themeMode: newThemeMode));

    _saveThemePreference(newThemeMode);
  }

// ~ Dark Theme
  void _darkTheme(DarkTheme event, Emitter<ThemeState> emitter) {
    log('Dark theme event triggered');

    ThemeMode newThemeMode =
        darkTheme == lightTheme ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeData: darkTheme, themeMode: newThemeMode));

    _saveThemePreference(newThemeMode);
  }

//   void _emitNewTheme(ThemeData themeData) {
//     ThemeMode newThemeMode =
//         themeData == lightTheme ? ThemeMode.light : ThemeMode.dark;
//     emit(state.copyWith(themeData: themeData, themeMode: newThemeMode));

//     _saveThemePreference(newThemeMode);
//   }
}
