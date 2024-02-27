part of 'change_screen_index_bloc.dart';

sealed class ChangeScreenIndexEvent extends Equatable {
  const ChangeScreenIndexEvent();

  @override
  List<Object> get props => [];
}

class NextPageIndecChangeScreen extends ChangeScreenIndexEvent {
  final int index;

  const NextPageIndecChangeScreen({required this.index});

  @override
  List<Object> get props => [index];
}
