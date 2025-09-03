import 'package:get/get.dart';
import 'package:messenger/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:messenger/features/auth/data/sources/remote/auth_remote_data_source.dart';
import 'package:messenger/features/auth/domain/repository/auth_repository.dart';
import 'package:messenger/features/auth/domain/usecase/login_usecase.dart';
import 'package:messenger/features/auth/domain/usecase/register_usecase.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRemoteDataSource());
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      fenix: true,
    );
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => RegisterUsecase(Get.find()));
  }
}
