import 'package:messenger/core/constants/firebase_constant.dart';
import 'package:messenger/features/profile/data/model/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRemoteSource {
  Future<UserModel> getUser() async {
    final doc = FirebaseConstant.firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(FirebaseConstant.currentUser!.uid);
    final snapshot = await doc.get();
    if (!snapshot.exists) {
      throw Exception('User not found');
    }
    return UserModel.fromJson(snapshot.data()!);
  }

  Future<void> createUser(UserModel user) async {
    final doc = FirebaseConstant.firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(FirebaseConstant.currentUser!.uid);
    UserModel newUser = UserModel(
      uid: FirebaseConstant.currentUser!.uid,
      email: FirebaseConstant.currentUser!.email!,
      name: user.name,
      photoUrl: user.photoUrl,
      phone: user.phone,
      description: user.description,
    );
    await doc.set(newUser.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    final doc = FirebaseConstant.firestore
        .collection(FirebaseConstant.usersCollection)
        .doc(FirebaseConstant.currentUser!.uid);
    await doc.update(user.toJson());
  }

  Future<void> signOut() async {
    FirebaseConstant.currentUser = null;
    await FirebaseAuth.instance.signOut();
  }
}
