import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messenger/core/utils/enums.dart';
part 'chats_entity.freezed.dart';

@freezed
abstract class ChatsEntity with _$ChatsEntity {
  const factory ChatsEntity({
    @Default('') String id,
    @Default(ChatType.private) ChatType type,
    @Default([]) List<String> participants,
    @Default('') String? lastMessage,
    @Default('') String? lastMessageSender,
    @Default(false) bool isBlocked,
    DateTime? updatedAt,
    @Default('') String? lastMessageId,
  }) = _ChatsEntity;
}
