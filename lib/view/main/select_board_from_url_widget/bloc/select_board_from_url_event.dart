import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

abstract class SelectBoardFromUrlEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends SelectBoardFromUrlEvent {}

class SavePin extends SelectBoardFromUrlEvent {
  SavePin({@required this.pinRequestModel});

  final PinRequestModel pinRequestModel;
}
