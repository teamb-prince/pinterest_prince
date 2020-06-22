import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends Equatable {
  UserModel({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.profileImageUrl,
    @required this.description,
    @required this.location,
    @required this.web,
    @required this.createdAt,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      profileImageUrl: json['profile_image'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      web: json['web'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  final String id;
  final String firstName;
  final String lastName;
  final String profileImageUrl;
  final String description;
  final String location;
  final String web;
  final String createdAt;

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        profileImageUrl,
        description,
        location,
        web,
        createdAt,
      ];
}
