import 'package:equatable/equatable.dart';

abstract class PinDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestUser extends PinDetailEvent {
  RequestUser(this.id);

  final String id;
}
