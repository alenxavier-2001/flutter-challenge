import 'package:json_annotation/json_annotation.dart';

part 'eventmodel.g.dart';

@JsonSerializable()
class EventModel {
  String? name;
  String? phoneNumber;
  String? startTime;
  String? endTime;
  String? date;

  EventModel(
      {required this.name,
      required this.phoneNumber,
      required this.startTime,
      required this.endTime,
      required this.date});

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
