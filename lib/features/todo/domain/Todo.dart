import 'package:freezed_annotation/freezed_annotation.dart';

part 'Todo.freezed.dart';
part 'Todo.g.dart';

@freezed
class Todo with _$Todo {

  factory Todo({
    required String title,
    required String description,
    @Default(false) bool done,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}