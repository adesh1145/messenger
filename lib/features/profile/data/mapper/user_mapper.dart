import 'package:messenger/features/profile/data/model/user_model/user_model.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';

extension UserMapper on User {
  UserModel toModel() => UserModel(
    uid: uid,
    email: email,
    name: name,
    photoUrl: photoUrl,
    phone: phone,
    description: description,
  );
}

extension UserModelMapper on UserModel {
  User toEntity() => User(
    uid: uid,
    email: email,
    name: name,
    photoUrl: photoUrl,
    phone: phone,
    description: description,
  );
}
