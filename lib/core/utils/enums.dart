enum MessageType { text, image, video, file }

extension MessageTypeExtension on MessageType {
  String get value {
    switch (this) {
      case MessageType.text:
        return "text";
      case MessageType.image:
        return "image";
      case MessageType.video:
        return "video";
      case MessageType.file:
        return "file";
    }
  }

  static MessageType fromValue(String value) {
    switch (value) {
      case "text":
        return MessageType.text;
      case "image":
        return MessageType.image;
      case "video":
        return MessageType.video;
      case "file":
        return MessageType.file;
      default:
        throw Exception("Invalid value: $value");
    }
  }
}

enum ChatType { private, group }

extension ChatTypeExtension on ChatType {
  String get value {
    switch (this) {
      case ChatType.private:
        return "private";
      case ChatType.group:
        return "group";
    }
  }

  static ChatType fromValue(String value) {
    switch (value) {
      case "private":
        return ChatType.private;
      case "group":
        return ChatType.group;
      default:
        throw Exception("Invalid value: $value");
    }
  }
}

enum MessageStatus { sent, received, seen }

extension MessageStatusExtension on MessageStatus {
  String get value {
    switch (this) {
      case MessageStatus.sent:
        return "sent";
      case MessageStatus.received:
        return "received";
      case MessageStatus.seen:
        return "seen";
    }
  }

  static MessageStatus fromValue(String value) {
    switch (value) {
      case "sent":
        return MessageStatus.sent;
      case "received":
        return MessageStatus.received;
      case "seen":
        return MessageStatus.seen;
      default:
        throw Exception("Invalid value: $value");
    }
  }
}

enum MessageChangeType { added, modified, removed }

enum CallType { video, audio }

extension CallTypeExtension on CallType {
  String get value {
    switch (this) {
      case CallType.video:
        return "video";
      case CallType.audio:
        return "audio";
    }
  }

  static CallType fromValue(String value) {
    switch (value) {
      case "video":
        return CallType.video;
      case "audio":
        return CallType.audio;
      default:
        throw Exception("Invalid value: $value");
    }
  }
}

enum CallState {
  calling,
  ringing,
  connecting,
  connected,
  ended,
  rejected,
  failed,
}

extension CallStateExtension on CallState {
  String get value {
    switch (this) {
      case CallState.calling:
        return "calling";
      case CallState.ringing:
        return "ringing";
      case CallState.connecting:
        return "connecting";
      case CallState.connected:
        return "connected";
      case CallState.ended:
        return "ended";
      case CallState.rejected:
        return "rejected";
      case CallState.failed:
        return "failed";
    }
  }

  static CallState fromValue(String value) {
    switch (value) {
      case "calling":
        return CallState.calling;
      case "ringing":
        return CallState.ringing;
      case "connecting":
        return CallState.connecting;
      case "connected":
        return CallState.connected;
      case "ended":
        return CallState.ended;
      case "rejected":
        return CallState.rejected;
      case "failed":
        return CallState.failed;
      default:
        throw Exception("Invalid value: $value");
    }
  }
}

enum CallDirection { incoming, outgoing }

extension CallDirectionExtension on CallDirection {
  String get value {
    switch (this) {
      case CallDirection.incoming:
        return "incoming";
      case CallDirection.outgoing:
        return "outgoing";
    }
  }

  static CallDirection fromValue(String value) {
    switch (value) {
      case "incoming":
        return CallDirection.incoming;
      case "outgoing":
        return CallDirection.outgoing;
      default:
        throw Exception("Invalid value: $value");
    }
  }
}

enum IceConnectionState { connected, disconnected, failed }

enum SdpType { offer, answer }

extension SdpTypeExtension on SdpType {
  String get value {
    switch (this) {
      case SdpType.offer:
        return 'offer';
      case SdpType.answer:
        return 'answer';
    }
  }

  static SdpType fromValue(String value) {
    switch (value) {
      case 'offer':
        return SdpType.offer;
      case 'answer':
        return SdpType.answer;
      default:
        throw ArgumentError('Invalid SdpType value: $value');
    }
  }
}
