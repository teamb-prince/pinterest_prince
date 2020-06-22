import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SignUpState {}

class LoadingState extends SignUpState {}

class SuccessState extends SignUpState {}

class ErrorState extends SignUpState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}