import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class PinsListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends PinsListState {}

class LoadedState extends PinsListState {
  LoadedState(this.pins);

  final List<PinModel> pins;

  @override
  List<Object> get props => [pins];
}

class NoDataState extends PinsListState {}

class ErrorState extends PinsListState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}