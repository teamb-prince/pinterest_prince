import 'package:pintersest_clone/api/image_api.dart';
import 'package:pintersest_clone/model/image_model.dart';

class ImageRepository {
  ImageRepository(this._imageApi);

  final ImageApi _imageApi;

  Future<ImageModel> crawlingImageFromUrl(String url) =>
      _imageApi.crawlingImageFromUrl(url);
}
