import 'package:equatable/equatable.dart';

abstract class CrawlingImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestSearch extends CrawlingImageEvent {
  RequestSearch(this.url);

  final String url;
}
