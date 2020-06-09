import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String imageUrl;

  ImageModel({this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json['image_url'] as String
    );
  }

  @override
  List<Object> get props => [imageUrl];
}

