import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/core/constants/firebase_constant.dart';
import 'package:messenger/features/chat/data/models/chat_model.dart';
import 'package:messenger/features/chat/data/models/messege_model.dart';
import 'package:messenger/features/chat/domain/entities/chats_entity.dart';
import 'package:messenger/features/profile/data/model/user_model/user_model.dart';

import '../../../../../core/utils/enums.dart';
import '../../models/message_event.dart';

class ChatRemoteSource {
  Future<ChatModel> createChat(String userId) async {
    final firestore = FirebaseConstant.firestore;
    final currentUserId =
        FirebaseConstant.currentUser?.uid; // apna userId le lo
    final participants = [currentUserId!, userId]..sort();
    final chatId = participants.join("_");

    final docRef = firestore
        .collection(FirebaseConstant.chatsCollection)
        .doc(chatId);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      return ChatModel.fromJson(docSnap.data()!);
    }

    final newChat = ChatModel(
      id: chatId,
      participants: participants,
      updatedAt: DateTime.now(),
    );

    await docRef.set(newChat.toJson());

    return newChat;
  }

  Future<List<UserModel>> searchUser(String query) async {
    final result = await FirebaseConstant.firestore
        .collection(FirebaseConstant.usersCollection)
        .where(FirebaseConstant.email, isEqualTo: query)
        .limit(50)
        .get();
    return result.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<UserModel> getUser(String uid) async {
    final result = await FirebaseConstant.firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(uid)
        .get();

    return UserModel.fromJson(result.data() as Map<String, dynamic>);
  }

  Stream<List<ChatModel>> getChats() {
    final currentUserId = FirebaseConstant.currentUser!.uid;
    final chatsRef = FirebaseConstant.firestore
        .collection(FirebaseConstant.chatsCollection)
        .where(FirebaseConstant.participants, arrayContains: currentUserId)
        .orderBy("updatedAt", descending: true);

    return chatsRef.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList(),
    );
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    final messagesRef = FirebaseConstant.firestore
        .collection(FirebaseConstant.chatsCollection)
        .doc(chatId)
        .collection(FirebaseConstant.messagesCollection)
        .orderBy("createdAt", descending: true);

    return messagesRef.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList(),
    );
  }

  Stream<MessageEvent> getMessageEvents(String chatId) {
    final messagesRef = FirebaseConstant.firestore
        .collection(FirebaseConstant.chatsCollection)
        .doc(chatId)
        .collection(FirebaseConstant.messagesCollection)
        .orderBy("createdAt", descending: true);

    return messagesRef.snapshots().expand((snapshot) {
      return snapshot.docChanges.map((change) {
        final message = MessageModel.fromJson(change.doc.data()!);

        if (change.type == DocumentChangeType.added) {
          return MessageEvent(type: MessageChangeType.added, message: message);
        } else if (change.type == DocumentChangeType.modified) {
          return MessageEvent(
            type: MessageChangeType.modified,
            message: message,
          );
        } else {
          return MessageEvent(
            type: MessageChangeType.removed,
            message: message,
          );
        }
      });
    });
  }

  Future<void> sendMessage(String chatId, MessageModel message) async {
    final messagesRef = FirebaseConstant.firestore
        .collection(FirebaseConstant.chatsCollection)
        .doc(chatId)
        .collection(FirebaseConstant.messagesCollection)
        .doc(message.id);

    final chatRoomRef = FirebaseConstant.firestore
        .collection(FirebaseConstant.chatsCollection)
        .doc(chatId);

    // Add message
    await messagesRef.set(message.toJson());

    // Update chat room metadata
    chatRoomRef.update({
      "lastMessage": message.content,
      "updatedAt": message.createdAt,
      "lastMessageSender": message.senderId,
      "lastMessageId": message.id,
    });
  }

  Future<void> deleteMessage(String chatId, String messageId) async {
    final docRef = FirebaseConstant.firestore
        .collection(FirebaseConstant.chatsCollection)
        .doc(chatId)
        .collection(FirebaseConstant.messagesCollection)
        .doc(messageId);

    await docRef.delete();
  }
}
