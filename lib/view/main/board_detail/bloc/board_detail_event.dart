import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BoardDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPins extends BoardDetailEvent {
  LoadPins({@required this.boardId});

  final String boardId;
}
