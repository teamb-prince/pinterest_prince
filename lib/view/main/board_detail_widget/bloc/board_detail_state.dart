import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class BoardDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends BoardDetailState {}

class LoadedState extends BoardDetailState {
  LoadedState(this.pins);

  final List<PinModel> pins;

  @override
  List<Object> get props => [pins];
}

class NoPinsState extends BoardDetailState {}

class ErrorState extends BoardDetailState {
  ErrorState(this.exception);

  final Exception exception;
}
