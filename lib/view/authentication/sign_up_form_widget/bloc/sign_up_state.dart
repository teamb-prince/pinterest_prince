import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/user_model.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SignUpState {}

class LoadingState extends SignUpState {}

class SuccessState extends SignUpState {
  SuccessState(this.userModel);

  final UserModel userModel;
}

class ErrorState extends SignUpState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
