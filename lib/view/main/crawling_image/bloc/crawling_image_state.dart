import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/image_model.dart';

abstract class CrawlingImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends CrawlingImageState {}

class LoadingState extends CrawlingImageState {}

class LoadedState extends CrawlingImageState {
  final ImageModel imageModel;

  LoadedState(this.imageModel);

  @override
  List<Object> get props => [imageModel];
}

class NoImageState extends CrawlingImageState {}

class ErrorState extends CrawlingImageState {
  final Exception exception;

  ErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
