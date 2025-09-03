// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  id: json['id'] as String? ?? '',
  type: json['type'] as String? ?? 'private',
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  lastMessage: json['lastMessage'] as String? ?? '',
  lastMessageSender: json['lastMessageSender'] as String? ?? '',
  lastMessageId: json['lastMessageId'] as String? ?? '',
  isBlocked: json['isBlocked'] as bool? ?? false,
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'participants': instance.participants,
      'lastMessage': instance.lastMessage,
      'lastMessageSender': instance.lastMessageSender,
      'lastMessageId': instance.lastMessageId,
      'isBlocked': instance.isBlocked,
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
