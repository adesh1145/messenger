import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConstant {
  // instance

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User? currentUser = FirebaseAuth.instance.currentUser;
  // collection

  static const String usersCollection = "users";
  static const String chatsCollection = "chats";
  static const String roomsCollection = "rooms";
  static const String messagesCollection = "messages";
  static const String participants = "participants";

  // field

  static const String uid = "uid";
  static const String email = "email";
  static const String name = "name";
  static const String photoUrl = "photoUrl";
}
