import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/features/chat/data/models/messege_model.dart';
import 'package:messenger/features/chat/domain/entities/messege.dart';

extension MessageMapper on MessageModel {
  Message toEntity() => Message(
    id: id,
    content: content,
    type: MessageTypeExtension.fromValue(type),
    senderId: senderId,
    createdAt: createdAt,
    status: MessageStatusExtension.fromValue(status),
    seenBy: seenBy,
  );
}

extension MessageModelMapper on Message {
  MessageModel toModel() => MessageModel(
    id: id,
    content: content,
    type: type.value,
    senderId: senderId,
    createdAt: createdAt,
    status: status.value,
    seenBy: seenBy,
  );
}
