import 'package:messenger/core/utils/typedef.dart';

abstract class AuthRepository {
  ResultFutureT<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

  ResultFutureT<String> registerWithEmailPassword({
    required String email,
    required String password,
  });

  ResultFutureT<void> sendEmailVerification();

  ResultFutureT<bool> isEmailVerified();

  ResultFutureT<bool> isLoggedIn();
}
