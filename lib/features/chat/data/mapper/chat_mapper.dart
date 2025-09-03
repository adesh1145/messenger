import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/features/chat/data/models/chat_model.dart';
import 'package:messenger/features/chat/domain/entities/chats_entity.dart';

extension ChatMapper on ChatModel {
  ChatsEntity toEntity() {
    print(this);
    return ChatsEntity(
      id: id,
      participants: participants,
      updatedAt: updatedAt,
      lastMessage: lastMessage,
      lastMessageSender: lastMessageSender,
      isBlocked: isBlocked,
      type: ChatTypeExtension.fromValue(type),
      lastMessageId: lastMessageId,
    );
  }
}

extension ChatModelMapper on ChatsEntity {
  ChatModel toModel() {
    return ChatModel(
      id: id,
      participants: participants,
      updatedAt: updatedAt,
      lastMessage: lastMessage,
      lastMessageSender: lastMessageSender,
      isBlocked: isBlocked,
      type: type.value,
      lastMessageId: lastMessageId,
    );
  }
}
