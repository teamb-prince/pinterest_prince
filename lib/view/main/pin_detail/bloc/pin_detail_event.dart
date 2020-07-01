import 'package:equatable/equatable.dart';

abstract class PinDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends PinDetailEvent {
  LoadData(this.userId, this.pinId);

  final String userId;
  final String pinId;
}
