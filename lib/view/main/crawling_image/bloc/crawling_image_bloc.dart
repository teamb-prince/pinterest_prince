import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintersest_clone/data/image_repository.dart';
import 'package:pintersest_clone/model/image_model.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_event.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_state.dart';

class CrawlingImageBloc extends Bloc<CrawlingImageEvent, CrawlingImageState> {
  final ImageRepository _imageRepository;

  CrawlingImageBloc(this._imageRepository);

  @override
  CrawlingImageState get initialState => InitialState();

  @override
  Stream<CrawlingImageState> mapEventToState(CrawlingImageEvent event) async* {
    if (event is RequestSearch) {
      yield LoadingState();
      try {
        final ImageModel result =
            await _imageRepository.crawlingImageFromUrl(event.url);
        if (result.imageUrls.length == 0) {
          yield NoImageState();
        }
        yield LoadedState(result);
      } on Exception catch (e) {
        yield ErrorState(e);
      }
    }
  }
}
