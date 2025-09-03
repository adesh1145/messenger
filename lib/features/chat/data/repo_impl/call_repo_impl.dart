import 'package:messenger/core/errors/exception_handler.dart';
import 'package:messenger/core/utils/enums.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/domain/repository/call_repository.dart';
import 'package:messenger/features/chat/data/models/call_model.dart';
import 'package:messenger/features/chat/data/models/ice_candidate_model.dart';
import 'package:messenger/features/chat/data/models/participant.dart';
import 'package:messenger/features/chat/data/models/session_description.dart';

import '../sources/remote/meeting_service.dart';

class CallRepoImpl implements CallRepository {
  final CallDataSource calDataSource;
  CallRepoImpl(this.calDataSource);
  @override
  ResultVoid acceptCall(String callId, Participant me) {
    return exceptionHandler(() => calDataSource.acceptCall(callId, me));
  }

  @override
  ResultVoid addAnswer(String callId, SessionDescription answer) {
    return exceptionHandler(() => calDataSource.addAnswer(callId, answer));
  }

  @override
  ResultVoid addCandidate(String callId, IceCandidateModel candidate) {
    return exceptionHandler(
      () => calDataSource.addCandidate(callId, candidate),
    );
  }

  @override
  ResultVoid addOffer(String callId, SessionDescription offer) {
    return exceptionHandler(() => calDataSource.addOffer(callId, offer));
  }

  @override
  Stream<List<CallModel>> getCallStream() {
    return calDataSource.listenRoomsCallStatus();
  }

  @override
  Stream<List<SessionDescription>> listenAnswers(String callId) {
    return calDataSource.listenAnswers(callId);
  }

  @override
  Stream<List<IceCandidateModel>> listenCandidates(String callId) {
    return calDataSource.listenCandidates(callId);
  }

  @override
  Stream<List<SessionDescription>> listenOffers(String callId) {
    return calDataSource.listenOffers(callId);
  }

  @override
  ResultVoid makeCall(String receiverId, Participant me) {
    return exceptionHandler(() => calDataSource.makeCall(receiverId, me));
  }

  @override
  ResultVoid refreshRoom(String callId) {
    return exceptionHandler(() => calDataSource.maybeDeleteRoom(callId));
  }

  @override
  ResultVoid updateCallStatus(String callId, CallState status) {
    return exceptionHandler(
      () => calDataSource.changeCallStatus(callId, status),
    );
  }

  @override
  Stream<List<CallModel>> listenAllCallStream() {
    return calDataSource.listenRoomsCallStatus();
  }

  @override
  Stream<CallModel> listenCall(String callId) {
    return calDataSource.listenParticipants(callId);
  }
}
