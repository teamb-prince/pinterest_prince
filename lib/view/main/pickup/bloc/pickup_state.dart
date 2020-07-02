import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class PickupState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends PickupState {}

class LoadedState extends PickupState {
  LoadedState(this.pins);

  final List<PinModel> pins;

  @override
  List<Object> get props => [pins];
}

class NoDataState extends PickupState {}

class ErrorState extends PickupState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
