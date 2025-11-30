import 'package:json_annotation/json_annotation.dart';

part 'user_detail.g.dart';

@JsonSerializable()
class UserDetail {
  final String name;
  final String email;
  final String? profilePicture;
  final String? phoneNumber;
  final String? address;
  final String? occupation;
  
  UserDetail({
    required this.name,
    required this.email,
    this.profilePicture,
    this.phoneNumber,
    this.address,
    this.occupation,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
}
