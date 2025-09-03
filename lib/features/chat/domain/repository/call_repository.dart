import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/data/models/call_model.dart';
import 'package:messenger/features/chat/data/models/ice_candidate_model.dart';
import 'package:messenger/features/chat/data/models/participant.dart';
import 'package:messenger/features/chat/data/models/session_description.dart';

abstract class CallRepository {
  ResultVoid makeCall(String receiverId, Participant me);
  ResultVoid acceptCall(String callId, Participant me);
  ResultVoid addOffer(String callId, SessionDescription offer);
  ResultVoid addAnswer(String callId, SessionDescription answer);
  ResultVoid addCandidate(String callId, IceCandidateModel candidate);
  ResultVoid refreshRoom(String callId);
  ResultVoid updateCallStatus(String callId, CallState status);

  Stream<List<SessionDescription>> listenOffers(String callId);
  Stream<List<SessionDescription>> listenAnswers(String callId);
  Stream<List<IceCandidateModel>> listenCandidates(String callId);
  Stream<CallModel> listenCall(String callId);
  Stream<List<CallModel>> listenAllCallStream();
}
