import 'package:equatable/equatable.dart';

abstract class FollowEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends FollowEvent {}