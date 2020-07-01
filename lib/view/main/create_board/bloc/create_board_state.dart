import 'package:equatable/equatable.dart';

abstract class CreateBoardState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends CreateBoardState {}

class LoadingState extends CreateBoardState {}

class SuccessState extends CreateBoardState {}

class ErrorState extends CreateBoardState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}