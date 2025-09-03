import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:messenger/core/utils/timestamp_convertor.dart';
part 'messege_model.freezed.dart';
part 'messege_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default('') String id,
    @Default('') String senderId,
    @Default('') String content,
    @Default('text') String type,
    @TimestampConverter() DateTime? createdAt,
    @Default('sent') String status,
    @Default([]) List<String> seenBy,
  }) = _MessageModel;
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
