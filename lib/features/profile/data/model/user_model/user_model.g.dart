// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String? ?? '',
  email: json['email'] as String? ?? '',
  name: json['name'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  photoUrl: json['photoUrl'] as String? ?? '',
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
    };
