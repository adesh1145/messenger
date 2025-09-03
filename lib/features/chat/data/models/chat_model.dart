import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messenger/core/utils/timestamp_convertor.dart';
import 'package:messenger/features/profile/data/model/user_model/user_model.dart';
part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    @Default('') String id,
    @Default('private') String type,
    @Default([]) List<String> participants,
    @Default('') String? lastMessage,
    @Default('') String? lastMessageSender,
    @Default('') String? lastMessageId,
    @Default(false) bool isBlocked,
    @TimestampConverter() DateTime? updatedAt,
  }) = _ChatModel;
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
