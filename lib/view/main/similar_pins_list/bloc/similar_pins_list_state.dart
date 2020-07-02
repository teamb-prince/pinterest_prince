import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class SimilarPinsState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends SimilarPinsState {}

class LoadedState extends SimilarPinsState {
  LoadedState(this.pins);

  final List<PinModel> pins;

  @override
  List<Object> get props => [pins];
}

class NoDataState extends SimilarPinsState {}

class ErrorState extends SimilarPinsState {
  ErrorState(this.exception);

  final Exception exception;
}
