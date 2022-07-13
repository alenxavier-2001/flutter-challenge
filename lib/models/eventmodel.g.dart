// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'date': instance.date,
    };
