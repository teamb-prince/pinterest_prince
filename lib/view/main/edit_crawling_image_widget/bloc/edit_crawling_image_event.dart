import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

abstract class EditCrawlingImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SavePin extends EditCrawlingImageEvent {
  SavePin({@required this.pinRequestModel});

  final PinRequestModel pinRequestModel;
}
