import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase implements UseCaseWithParams<String, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUsecase(this.authRepository);

  @override
  ResultFutureT<String> call(RegisterParams params) {
    return authRepository.registerWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  RegisterParams({required this.email, required this.password});
}
