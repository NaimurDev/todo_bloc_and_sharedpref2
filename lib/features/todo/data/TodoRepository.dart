import 'dart:convert';

import 'package:todo_list_app/core/utils/constants.dart';
import 'package:todo_list_app/features/todo/domain/repository/ITodoRepository.dart';
import 'package:todo_list_app/features/todo/domain/model/Todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoRepository implements ITodoRepository {
  final SharedPreferences localStore;

  TodoRepository({required this.localStore});

  @override
  Future<List<Todo>> initialSetFunc() async {
    if (localStore.getString(AppPref.todos) == null) {
      localStore.setString(AppPref.todos, json.encode([]));
      return [];
    } else {
      return _getSavedTodoList();
    }
  }

  @override
  Future<void> addTodo(String todoTitle, String todoDesc) async {
    var todosList = await _getSavedTodoList();
    todosList.add(Todo(title: todoTitle, description: todoDesc));
    localStore.setString(AppPref.todos, json.encode(todosList));
  }

  @override
  Future<void> deleteTodo(int i) async {
    var todosList = await _getSavedTodoList();
    todosList.removeAt(i);
    localStore.setString(AppPref.todos, json.encode(todosList));
  }

  @override
  Future<void> toggleDone(int index) async {
    var todosList = await _getSavedTodoList();
    todosList[index] = todosList[index].copyWith(done: !todosList[index].done);
    localStore.setString(AppPref.todos, json.encode(todosList));
  }

  Future<List<Todo>> _getSavedTodoList() async {
    var todoList = <Todo>[];
    final todoData = json.decode(localStore.getString(AppPref.todos) ?? "[]");
    for (var todo in todoData) {
      var t = Todo.fromJson(todo);
      todoList.add(t);
    }
    return todoList;
  }
}
