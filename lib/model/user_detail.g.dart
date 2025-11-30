// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) => UserDetail(
  name: json['name'] as String,
  email: json['email'] as String,
  profilePicture: json['profilePicture'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  address: json['address'] as String?,
  occupation: json['occupation'] as String?,
);

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'occupation': instance.occupation,
    };
