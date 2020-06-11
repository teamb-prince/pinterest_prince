import 'package:equatable/equatable.dart';

abstract class SearchImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestSearch extends SearchImageEvent {
  final String url;

  RequestSearch(this.url);
}
