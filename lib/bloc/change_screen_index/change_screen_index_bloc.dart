// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_screen_index_event.dart';
part 'change_screen_index_state.dart';

class ChangeScreenIndexBloc
    extends Bloc<ChangeScreenIndexEvent, ChangeScreenIndexState> {
  ChangeScreenIndexBloc() : super(const ChangeScreenIndexState()) {
    on<NextPageIndecChangeScreen>(_nextPageIndecChangeScreen);
  }

  void _nextPageIndecChangeScreen(NextPageIndecChangeScreen event,
      Emitter<ChangeScreenIndexState> emitter) {
    log(event.index.toString());

    emit(state.copyWith(index: event.index));
  }
}
