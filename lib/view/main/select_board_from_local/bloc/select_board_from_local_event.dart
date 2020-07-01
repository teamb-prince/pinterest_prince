import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

abstract class SelectBoardFromLocalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBoards extends SelectBoardFromLocalEvent {}

class SavePin extends SelectBoardFromLocalEvent {
  SavePin({@required this.image, @required this.pinRequestModel});

  final File image;
  final PinRequestModel pinRequestModel;
}
