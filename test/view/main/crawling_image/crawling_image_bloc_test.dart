import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/api/errors/error.dart';
import 'package:pintersest_clone/data/image_repository.dart';
import 'package:pintersest_clone/model/image_model.dart';
import 'package:pintersest_clone/view/main/crawling_image/bloc/bloc.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main() {
  MockImageRepository mockImageRepository;
  const imageModel = ImageModel(
      url: 'url',
      imageUrls: ['url 1', 'url 2'],
      description: null,
      title: null);

  group('SearchImageBloc test', () {
    setUp(() async {
      mockImageRepository = MockImageRepository();
    });

    blocTest<CrawlingImageBloc, CrawlingImageEvent, CrawlingImageState>(
      'emit [InitialState(), LoadingState(), LoadedState()] when request will succeed',
      build: () async {
        when(mockImageRepository.crawlingImageFromUrl(any))
            .thenAnswer((_) => Future.value(imageModel));

        return CrawlingImageBloc(mockImageRepository);
      },
      // ignore: missing_return
      act: (bloc) {
        bloc.add(RequestSearch('url'));
      },
      skip: 0,
      expect: <CrawlingImageState>[
        InitialState(),
        LoadingState(),
        LoadedState(imageModel)
      ],
    );

    blocTest<CrawlingImageBloc, CrawlingImageEvent, CrawlingImageState>(
      'emit [InitialState(), LoadingState(), ErrorState()] when request will fail',
      build: () async {
        when(mockImageRepository.crawlingImageFromUrl(any))
            .thenAnswer((_) => Future.error(UnauthorizedError()));

        return CrawlingImageBloc(mockImageRepository);
      },
      // ignore: missing_return
      act: (bloc) {
        bloc.add(RequestSearch('url'));
      },
      skip: 0,
      expect: <dynamic>[InitialState(), LoadingState(), isA<ErrorState>()],
    );
  });
}
