import 'package:equatable/equatable.dart';

abstract class CrawlingImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestSearch extends CrawlingImageEvent {
  final String url;

  RequestSearch(this.url);
}
