import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class BoardsListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends BoardsListState {}

class LoadedBoardsState extends BoardsListState {
  LoadedBoardsState(this.boards);

  final List<BoardModel> boards;
}

class LoadedPinsState extends BoardsListState {
  LoadedPinsState(this.pins);

  final Map<String, List<PinModel>> pins;
}

class NoBoardsState extends BoardsListState {}

class ErrorState extends BoardsListState {
  ErrorState(this.exception);

  final Exception exception;
}
