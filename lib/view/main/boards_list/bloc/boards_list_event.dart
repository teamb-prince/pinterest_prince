import 'package:equatable/equatable.dart';

abstract class BoardsListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends BoardsListEvent {}