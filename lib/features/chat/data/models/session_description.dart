import 'package:messenger/core/utils/enums.dart';

class SessionDescription {
  final String from;
  final String to;
  final SdpType type;
  final String sdp;

  SessionDescription({
    required this.from,
    required this.to,
    required this.type,
    required this.sdp,
  });

  Map<String, dynamic> toMap() {
    return {'from': from, 'to': to, 'type': type.value, 'sdp': sdp};
  }

  factory SessionDescription.fromMap(Map<String, dynamic> map) {
    return SessionDescription(
      from: map['from'],
      to: map['to'],
      type: SdpTypeExtension.fromValue(map['type'].toString()),
      sdp: map['sdp'],
    );
  }
}
