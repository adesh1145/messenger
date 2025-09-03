import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/features/chat/data/models/messege_model.dart';

class MessageEvent {
  final MessageChangeType type;
  final MessageModel message;

  MessageEvent({required this.type, required this.message});
}
