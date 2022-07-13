// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responsemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      success: json['success'] as bool,
      data: json['data'] as List<dynamic>,
      errors: json['errors'] as List<dynamic>,
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'msg': instance.msg,
      'errors': instance.errors,
    };
