import 'package:equatable/equatable.dart';
import 'package:pintersest_clone/model/board_request_model.dart';

abstract class CreateBoardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveBoard extends CreateBoardEvent {
  SaveBoard(this.boardRequestModel);

  final BoardRequestModel boardRequestModel;
}