import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {
  final List<PinModel> pins;

  LoadedState(this.pins);

  @override
  List<Object> get props => [pins];
}

class NoDataState extends HomeState {}

class ErrorState extends HomeState {
  final Exception exception;

  ErrorState(this.exception);
}
