part of 'change_screen_index_bloc.dart';

class ChangeScreenIndexState extends Equatable {
  final int index;
  const ChangeScreenIndexState({this.index = 0});

  ChangeScreenIndexState copyWith({int? index}) {
    return ChangeScreenIndexState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}
