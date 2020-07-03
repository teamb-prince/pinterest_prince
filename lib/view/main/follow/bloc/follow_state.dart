import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/user_model.dart';

abstract class FollowState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends FollowState {}

class LoadedDataState extends FollowState {
  LoadedDataState(this.users, this.pins);

  final List<UserModel> users;
  final Map<String, List<PinModel>> pins;
}

class NoDataState extends FollowState {}

class ErrorState extends FollowState {
  ErrorState(this.exception);

  final Exception exception;
}
