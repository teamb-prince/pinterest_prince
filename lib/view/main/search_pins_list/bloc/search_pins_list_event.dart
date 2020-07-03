import 'package:equatable/equatable.dart';

abstract class SearchPinsListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends SearchPinsListEvent {
  LoadData(this.label);

  final String label;
}
