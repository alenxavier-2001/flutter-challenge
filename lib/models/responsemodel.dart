import 'package:json_annotation/json_annotation.dart';
part 'responsemodel.g.dart';

@JsonSerializable()
class ResponseModel {
  bool success;
  List data;
  String msg;
  List errors;

  ResponseModel(
      {required this.success,
      required this.data,
      required this.errors,
      required this.msg});
  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
