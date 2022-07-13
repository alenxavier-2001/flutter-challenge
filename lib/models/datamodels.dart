import 'package:json_annotation/json_annotation.dart';
part 'datamodels.g.dart';

@JsonSerializable()
class DataModels {
  bool success;
  Map data;
  String msg;
  List errors;
  DataModels(
      {required this.success,
      required this.data,
      required this.errors,
      required this.msg});
  factory DataModels.fromJson(Map<String, dynamic> json) =>
      _$DataModelsFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelsToJson(this);
}
