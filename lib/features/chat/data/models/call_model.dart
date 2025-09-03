import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/features/chat/data/models/participant.dart';

class CallModel {
  final String roomId;
  final bool isGroupCall;
  final DateTime createdAt;
  final CallType callType;
  final CallState callStatus;
  final List<Participant> participants;

  CallModel({
    required this.roomId,
    this.isGroupCall = false,
    required this.createdAt,
    required this.callType,
    required this.callStatus,
    required this.participants,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,

      'isGroupCall': isGroupCall,
      'createdAt': createdAt.toIso8601String(),
      'callType': callType.value,
      'callStatus': callStatus.value,
      'participants': participants.map((p) => p.toMap()).toList(),
    };
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      roomId: map['roomId'] as String,

      isGroupCall: map['isGroupCall'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
      callType: CallTypeExtension.fromValue(map['callType'].toString()),
      callStatus: CallStateExtension.fromValue(map['callStatus'].toString()),
      participants: (map['participants'] as List<dynamic>? ?? [])
          .map((p) => Participant.fromMap(p as Map<String, dynamic>))
          .toList(),
    );
  }
}
