class IceCandidateModel {
  final String from;
  final String to;
  final String candidate;
  final String? sdpMid;
  final int? sdpMLineIndex;

  IceCandidateModel({
    required this.from,
    required this.to,
    required this.candidate,
    this.sdpMid,
    this.sdpMLineIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
      'candidate': candidate,
      'sdpMid': sdpMid,
      'sdpMLineIndex': sdpMLineIndex,
    };
  }

  factory IceCandidateModel.fromMap(Map<String, dynamic> map) {
    return IceCandidateModel(
      from: map['from'],
      to: map['to'],
      candidate: map['candidate'],
      sdpMid: map['sdpMid'],
      sdpMLineIndex: map['sdpMLineIndex'],
    );
  }
}
