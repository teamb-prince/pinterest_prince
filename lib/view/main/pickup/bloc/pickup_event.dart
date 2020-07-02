import 'package:equatable/equatable.dart';

abstract class PickupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends PickupEvent {
  LoadData(this.id);

  final int id;
}
