import 'package:equatable/equatable.dart';

abstract class SimilarPinsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends SimilarPinsEvent {
  LoadData(this.label);

  final String label;
}
