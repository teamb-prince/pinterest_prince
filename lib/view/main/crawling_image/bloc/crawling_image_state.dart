import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/image_model.dart';

abstract class SearchImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SearchImageState {}

class LoadingState extends SearchImageState {}

class LoadedState extends SearchImageState {
  final ImageModel imageModel;

  LoadedState(this.imageModel);

  @override
  List<Object> get props => [imageModel];
}

class NoImageState extends SearchImageState {}

class ErrorState extends SearchImageState {
  final Exception exception;

  ErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
