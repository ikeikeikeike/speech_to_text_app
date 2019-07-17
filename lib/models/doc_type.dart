import 'package:json_annotation/json_annotation.dart';

part 'doc_type.g.dart';

@JsonSerializable()
class DocTypeModel {
  List<String> data;

  DocTypeModel(this.data);

  factory DocTypeModel.fromJson(Map<String, dynamic> json) =>
      _$DocTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocTypeModelToJson(this);
}
