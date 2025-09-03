import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') @JsonKey(defaultValue: '') String uid,
    @Default('') @JsonKey(defaultValue: '') String email,
    @Default('') String name,
    @Default('') @JsonKey(defaultValue: '') String phone,
    @Default('') String photoUrl,
    @Default('') String description,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
