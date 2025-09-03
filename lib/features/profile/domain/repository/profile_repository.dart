import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';

abstract class ProfileRepository {
  ResultFutureT<User> getUser();
  ResultFutureT<void> updateUser(User user);
  ResultFutureT<void> createUser(User user);

  ResultFutureT<void> signOut();
}
