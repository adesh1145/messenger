import 'package:messenger/core/errors/exception_handler.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/auth/data/sources/remote/auth_remote_data_source.dart';
import 'package:messenger/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  ResultFutureT<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    return exceptionHandler(
      () => remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  ResultFutureT<String> registerWithEmailPassword({
    required String email,
    required String password,
  }) {
    return exceptionHandler(
      () => remoteDataSource.registerWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  ResultFutureT<void> sendEmailVerification() {
    return exceptionHandler(() => remoteDataSource.sendEmailVerification());
  }

  @override
  ResultFutureT<bool> isEmailVerified() {
    return exceptionHandler(() => remoteDataSource.isEmailVerified());
  }

  @override
  ResultFutureT<bool> isLoggedIn() {
    return exceptionHandler(() => remoteDataSource.isLoggedIn());
  }
}
