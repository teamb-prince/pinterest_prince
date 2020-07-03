import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/pin_model.dart';

abstract class SearchPinsListState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends SearchPinsListState {}

class LoadedState extends SearchPinsListState {
  LoadedState(this.pins);

  final List<PinModel> pins;

  @override
  List<Object> get props => [pins];
}

class NoDataState extends SearchPinsListState {}

class ErrorState extends SearchPinsListState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
