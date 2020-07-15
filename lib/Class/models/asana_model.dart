import 'package:json_annotation/json_annotation.dart';

part 'asana_model.g.dart';

@JsonSerializable()
class AsanaModel {
  AsanaModel(
    this.uniqueName,
    this.title,
    this.imageUrl,
    this.level,
    this.description,
    this.benefits,
  );

  final String uniqueName;
  final String title;
  final String imageUrl;
  final double level;
  final String description;
  final String benefits;

  factory AsanaModel.fromJson(Map<String, dynamic> json) =>
      _$AsanaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AsanaModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsanaModel &&
          runtimeType == other.runtimeType &&
          uniqueName == other.uniqueName &&
          title == other.title &&
          imageUrl == other.imageUrl &&
          level == other.level &&
          description == other.description &&
          benefits == other.benefits;

  @override
  int get hashCode =>
      uniqueName.hashCode ^
      title.hashCode ^
      imageUrl.hashCode ^
      level.hashCode ^
      description.hashCode ^
      benefits.hashCode;
}
