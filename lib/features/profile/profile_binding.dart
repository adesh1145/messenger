import 'package:get/get.dart';
import 'package:messenger/features/profile/data/source/remote/profile_remote_source.dart';
import 'package:messenger/features/profile/data/repo_impl/profile_repo_impl.dart';
import 'package:messenger/features/profile/domain/repository/profile_repository.dart';
import 'package:messenger/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:messenger/features/profile/domain/usecase/update_profile_usecase.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {}
}
