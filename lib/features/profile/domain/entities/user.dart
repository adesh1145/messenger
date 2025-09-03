import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String uid,
    required String email,
    @Default('') String name,
    @Default('') String photoUrl,
    @Default('') String phone,
    @Default('') String description,
  }) = _User;
}
