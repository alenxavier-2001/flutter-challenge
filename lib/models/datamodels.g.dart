// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModels _$DataModelsFromJson(Map<String, dynamic> json) => DataModels(
      success: json['success'] as bool,
      data: json['data'] as Map<String, dynamic>,
      errors: json['errors'] as List<dynamic>,
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$DataModelsToJson(DataModels instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'msg': instance.msg,
      'errors': instance.errors,
    };
