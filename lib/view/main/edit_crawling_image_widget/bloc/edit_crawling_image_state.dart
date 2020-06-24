import 'package:equatable/equatable.dart';

abstract class EditCrawlingImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends EditCrawlingImageState {}

class NoDataState extends EditCrawlingImageState {}

class ErrorState extends EditCrawlingImageState {
  ErrorState(this.exception);

  final Exception exception;
}

class SavedPinState extends EditCrawlingImageState {}
