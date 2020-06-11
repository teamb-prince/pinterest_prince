import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/image_repository.dart';
import 'package:pintersest_clone/model/image_model.dart';
import 'package:pintersest_clone/view/main/search_image/search_image_event.dart';
import 'package:pintersest_clone/view/main/search_image/search_image_state.dart';

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
            await _imageRepository.crawlingImageFromUrl(event.url);
        if (result.imageUrls.length == 0) {
          yield NoImageState();
        }
        yield LoadedState(result);
      } catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
