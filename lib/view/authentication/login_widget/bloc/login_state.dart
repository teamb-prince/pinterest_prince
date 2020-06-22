import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}