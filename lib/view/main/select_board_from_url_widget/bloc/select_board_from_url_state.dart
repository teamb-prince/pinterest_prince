import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/board_model.dart';

abstract class SelectBoardFromUrlState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends SelectBoardFromUrlState {}

class LoadedState extends SelectBoardFromUrlState {
  LoadedState(this.boards);

  final List<BoardModel> boards;

  @override
  List<Object> get props => [boards];
}

class NoDataState extends SelectBoardFromUrlState {}

class ErrorState extends SelectBoardFromUrlState {
  ErrorState(this.exception);

  final Exception exception;
}

class SavedPinState extends SelectBoardFromUrlState {}
