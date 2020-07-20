// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asana_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AsanaModel _$AsanaModelFromJson(Map<String, dynamic> json) {
  return AsanaModel(
    json['uniqueName'] as String,
    json['title'] as String,
    json['imageUrl'] as String,
    (json['level'] as num)?.toDouble(),
    json['description'] as String,
    json['benefits'] as String,
    json['videoUrl'] as String,
  );
}

Map<String, dynamic> _$AsanaModelToJson(AsanaModel instance) =>
    <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'level': instance.level,
      'description': instance.description,
      'benefits': instance.benefits,
      'videoUrl': instance.videoUrl,
    };
