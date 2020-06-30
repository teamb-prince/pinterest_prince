import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/user_model.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends AccountState {}

class LoadedState extends AccountState {
  LoadedState(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class ErrorSate extends AccountState {
  ErrorSate(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}


