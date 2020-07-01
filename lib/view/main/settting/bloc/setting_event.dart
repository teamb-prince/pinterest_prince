import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignOut extends SettingEvent {}