import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String url;
  final List<String> imageUrls;

  ImageModel({this.url, this.imageUrls});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'] as String,
      imageUrls: (json['image_url'] as List).cast<String>(),
    );
  }

  @override
  List<Object> get props => [url, imageUrls];
}

