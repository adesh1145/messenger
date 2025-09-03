import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/core/constants/firebase_constant.dart';

class AuthRemoteDataSource {
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseConstant.currentUser = res.user;
    return res.user?.uid ?? "";
  }

  Future<String> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseConstant.currentUser = res.user;
    return res.user?.uid ?? "";
  }

  Future<void> sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.emailVerified ?? false;
  }

  Future<bool> isLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseConstant.currentUser = user;
    return user != null;
  }
}
