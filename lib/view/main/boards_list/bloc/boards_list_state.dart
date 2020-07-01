import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/board_model.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class BoardsListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends BoardsListState {}

class LoadedDataState extends BoardsListState {
  LoadedDataState(this.boards, this.pins);

  final List<BoardModel> boards;
  final Map<String, List<PinModel>> pins;
}

class NoDataState extends BoardsListState {}

class ErrorState extends BoardsListState {
  ErrorState(this.exception);

  final Exception exception;
}
