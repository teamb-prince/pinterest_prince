import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/image_model.dart';

abstract class CrawlingImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends CrawlingImageState {}

class LoadingState extends CrawlingImageState {}

class LoadedState extends CrawlingImageState {
  LoadedState(this.imageModel);

  final ImageModel imageModel;

  @override
  List<Object> get props => [imageModel];
}

class NoImageState extends CrawlingImageState {}

class ErrorState extends CrawlingImageState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
