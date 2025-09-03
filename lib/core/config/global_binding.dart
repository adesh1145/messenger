import 'package:get/get.dart';
import 'package:messenger/features/profile/domain/usecase/create_profile_usecase.dart';
import 'package:messenger/features/profile/domain/usecase/logout_usecase.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';
import 'package:messenger/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:messenger/features/profile/domain/usecase/update_profile_usecase.dart';

import '../../features/profile/data/repo_impl/profile_repo_impl.dart';
import '../../features/profile/data/source/remote/profile_remote_source.dart';
import '../../features/profile/domain/repository/profile_repository.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRemoteSource>(() => ProfileRemoteSource());
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepoImpl(Get.find()),
      fenix: true,
    );

    Get.lazyPut<GetProfileUsecase>(() => GetProfileUsecase(Get.find()));
    Get.lazyPut<UpdateProfileUsecase>(() => UpdateProfileUsecase(Get.find()));
    Get.lazyPut<CreateProfileUsecase>(() => CreateProfileUsecase(Get.find()));
    Get.lazyPut<LogoutUsecase>(() => LogoutUsecase(Get.find()));

    Get.put<ProfileController>(
      ProfileController(Get.find(), Get.find(), Get.find(), Get.find()),
      permanent: true,
    );
  }
}
