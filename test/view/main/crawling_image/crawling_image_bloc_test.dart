import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/api/errors/error.dart';
import 'package:pintersest_clone/data/image_repository.dart';
import 'package:pintersest_clone/model/image_model.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_bloc.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_event.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/crawling_image_state.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main() {
  MockImageRepository mockImageRepository;
  final ImageModel imageModel =
      ImageModel(url: "url", imageUrls: ["url 1", 'url 2']);

  group("SearchImageBloc test", () {
    setUp(() async {
      mockImageRepository = MockImageRepository();
    });

    blocTest<SearchImageBloc, SearchImageEvent, SearchImageState>(
      "emit [InitialState(), LoadingState(), LoadedState()] when request will succeed",
      build: () async {
        when(mockImageRepository.crawlingImageFromUrl(any))
            .thenAnswer((_) => Future.value(imageModel));

        return SearchImageBloc(mockImageRepository);
      },
      act: (bloc) {
        bloc.add(RequestSearch("url"));
      },
      skip: 0,
      expect: <SearchImageState>[
        InitialState(),
        LoadingState(),
        LoadedState(imageModel)
      ],
    );

    blocTest<SearchImageBloc, SearchImageEvent, SearchImageState>(
      "emit [InitialState(), LoadingState(), ErrorState()] when request will fail",
      build: () async {
        when(mockImageRepository.crawlingImageFromUrl(any))
            .thenAnswer((_) => Future.error(UnauthorizedError()));

        return SearchImageBloc(mockImageRepository);
      },
      act: (bloc) {
        bloc.add(RequestSearch("url"));
      },
      skip: 0,
      expect: <dynamic>[InitialState(), LoadingState(), isA<ErrorState>()],
    );
  });
}
