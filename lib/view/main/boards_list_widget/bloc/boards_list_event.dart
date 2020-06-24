import 'package:equatable/equatable.dart';

abstract class BoardsListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBoards extends BoardsListEvent {}

class LoadPins extends BoardsListEvent {
  LoadPins(this.boardIds);

  final List<String> boardIds;
}
