import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messenger/core/utils/enums.dart';
part 'messege.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    @Default('') String id,
    @Default('') String senderId,
    @Default('') String content,
    @Default(MessageType.text) MessageType type,
    @Default(MessageStatus.sent) MessageStatus status,
    DateTime? createdAt,
    @Default([]) List<String> seenBy,
  }) = _Message;
}
