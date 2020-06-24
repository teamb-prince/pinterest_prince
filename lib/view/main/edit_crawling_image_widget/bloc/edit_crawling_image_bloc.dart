import 'package:bloc/bloc.dart';
import 'package:pintersest_clone/data/pins_repository.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_event.dart';
import 'package:pintersest_clone/view/main/edit_crawling_image_widget/bloc/edit_crawling_image_state.dart';

class EditCrawlingImageBloc
    extends Bloc<EditCrawlingImageEvent, EditCrawlingImageState> {
  EditCrawlingImageBloc(this._pinsRepository);

  final PinsRepository _pinsRepository;

  @override
  EditCrawlingImageState get initialState => LoadingState();

  @override
  Stream<EditCrawlingImageState> mapEventToState(
      EditCrawlingImageEvent event) async* {
    if (event is SavePin) {
      yield LoadingState();
      try {
        final pin = await _pinsRepository.savePin(event.pinRequestModel);
        print(pin.imageUrl);
        yield SavedPinState();
      } on Exception catch (e) {
        print(e);
        yield ErrorState(e);
      }
    }
  }
}
