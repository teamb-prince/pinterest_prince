import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/user_model.dart';

abstract class PinDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends PinDetailState {}

class LoadedState extends PinDetailState {
  LoadedState(this.userModel);

  final UserModel userModel;

  @override
  List<Object> get props => [userModel];
}

class NoDataState extends PinDetailState {}

class ErrorState extends PinDetailState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
