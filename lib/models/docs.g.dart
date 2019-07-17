// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'docs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocsModel _$DocsModelFromJson(Map<String, dynamic> json) {
  return DocsModel((json['data'] as List)
      ?.map((e) =>
          e == null ? null : DocsAttr.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$DocsModelToJson(DocsModel instance) =>
    <String, dynamic>{'data': instance.data};

DocsAttr _$DocsAttrFromJson(Map<String, dynamic> json) {
  return DocsAttr(
      json['id'] as int,
      json['document_id'] as int,
      json['document_type'] as String,
      Uri.parse(json['url'] as String),
      json['title'] as String,
      json['explain'] as String,
      DateTime.parse(json['date'] as String),
      json['subtype'] as String,
      Uri.parse(json['image'] as String));
}

Map<String, dynamic> _$DocsAttrToJson(DocsAttr instance) => <String, dynamic>{
      'id': instance.id,
      'document_id': instance.documentId,
      'document_type': instance.documentType,
      'url': instance.url.toString(),
      'title': instance.title,
      'explain': instance.explain,
      'date': instance.date.toIso8601String(),
      'subtype': instance.subtype,
      'image': instance.image.toString()
    };
