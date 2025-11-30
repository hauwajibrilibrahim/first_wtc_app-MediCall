// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  message: json['message'] as String,
  user: UserDetail.fromJson(json['user'] as Map<String, dynamic>),
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'message': instance.message,
  'user': instance.user,
  'date': instance.date.toIso8601String(),
};
