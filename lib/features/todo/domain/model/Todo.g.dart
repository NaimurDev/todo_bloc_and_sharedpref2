// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      done: json['done'] as bool? ?? false,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'done': instance.done,
    };
