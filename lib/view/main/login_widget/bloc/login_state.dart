import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final Exception exception;

  ErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}