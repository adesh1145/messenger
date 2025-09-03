// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messege_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['id'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      content: json['content'] as String? ?? '',
      type: json['type'] as String? ?? 'text',
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      status: json['status'] as String? ?? 'sent',
      seenBy:
          (json['seenBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'content': instance.content,
      'type': instance.type,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'status': instance.status,
      'seenBy': instance.seenBy,
    };
