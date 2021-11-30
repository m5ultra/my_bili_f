// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      json['status'] as int,
      json['msg'] as String,
      json['success'] as bool,
      json['token'] as String,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'success': instance.success,
      'token': instance.token,
    };
