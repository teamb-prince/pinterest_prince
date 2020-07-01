import 'package:equatable/equatable.dart';

abstract class PinsListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends PinsListEvent {}