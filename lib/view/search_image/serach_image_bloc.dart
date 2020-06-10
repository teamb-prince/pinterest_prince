import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/image_repository.dart';
import 'package:pintersest_clone/model/image_model.dart';

import '../../model/image_model.dart';

abstract class SearchImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestSearch extends SearchImageEvent {
  final String url;

  RequestSearch(this.url);
}

abstract class SearchImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SearchImageState {}

class LoadingState extends SearchImageState {}

class LoadedState extends SearchImageState {
  final ImageModel imageModel;

  LoadedState(this.imageModel);

  @override
  List<Object> get props => [imageModel];
}

class NoImageState extends SearchImageState {}

class ErrorState extends SearchImageState {
  final Exception exception;

  ErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}

class SearchImageBloc extends Bloc<SearchImageEvent, SearchImageState> {
  final ImageRepository _imageRepository;

  SearchImageBloc(this._imageRepository);

  @override
  SearchImageState get initialState => InitialState();

  @override
  Stream<SearchImageState> mapEventToState(SearchImageEvent event) async* {
    if (event is RequestSearch) {
      yield LoadingState();
      try {
        final ImageModel result =
            await _imageRepository.searchImageFromUrl(event.url);
        if (result.imageUrls.length == 0) {
          yield NoImageState();
        }
        yield LoadedState(result);
      } catch (e) {
        print(e);
        ErrorState(e);
      }
    }
  }
}
