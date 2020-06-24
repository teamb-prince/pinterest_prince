import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/board_model.dart';

abstract class SelectBoardFromLocalState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends SelectBoardFromLocalState {}

class LoadedState extends SelectBoardFromLocalState {
  LoadedState(this.boards);

  final List<BoardModel> boards;

  @override
  List<Object> get props => [boards];
}

class NoBoardsState extends SelectBoardFromLocalState {}

class ErrorState extends SelectBoardFromLocalState {
  ErrorState(this.exception);

  final Exception exception;
}

class SavedPinState extends SelectBoardFromLocalState {}