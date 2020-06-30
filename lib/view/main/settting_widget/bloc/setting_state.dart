import 'package:equatable/equatable.dart';

abstract class SettingState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SettingState {}

class LoadingState extends SettingState {}

class SuccessState extends SettingState {}

class ErrorState extends SettingState {
  ErrorState(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}