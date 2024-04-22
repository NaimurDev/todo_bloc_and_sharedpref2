import 'package:todo_list_app/features/todo/domain/model/Todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> initialSetFunc();
  Future<void> addTodo(String todoTitle, String todoDesc);
  Future<void> deleteTodo(int i);
  Future<void> toggleDone(int index);
}