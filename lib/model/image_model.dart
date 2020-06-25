import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ImageModel extends Equatable {
  const ImageModel(
      {@required this.url,
      @required this.imageUrls,
      @required this.title,
      @required this.description});

  factory ImageModel.fromJson(dynamic json) {
    return ImageModel(
      url: json['url'] as String,
      imageUrls: (json['image_url'] as List).cast<String>(),
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  final String url;
  final List<String> imageUrls;
  final String title;
  final String description;

  @override
  List<Object> get props => [url, imageUrls, title, description];
}
