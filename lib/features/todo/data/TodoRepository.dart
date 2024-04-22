import 'dart:convert';

import 'package:todo_list_app/core/utils/constants.dart';
import 'package:todo_list_app/features/todo/domain/repository/ITodoRepository.dart';
import 'package:todo_list_app/features/todo/domain/model/Todo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TodoRepository extends ITodoRepository {
  @override
  Future<List<Todo>> initialSetFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(AppPref.todos) == null) {
      prefs.setString(AppPref.todos, json.encode([]));
      return [];
    } else {
      return _getSavedTodoList();
    }
  }

  @override
  Future<void> addTodo(String todoTitle, String todoDesc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var todosList = await _getSavedTodoList();
    todosList.add(Todo(title: todoTitle, description: todoDesc));
    prefs.setString(AppPref.todos, json.encode(todosList));
  }

  @override
  Future<void> deleteTodo(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var todosList = await _getSavedTodoList();
    todosList.removeAt(i);
    prefs.setString(AppPref.todos, json.encode(todosList));
  }

    
  @override
  Future<void> toggleDone(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var todosList = await _getSavedTodoList();
    todosList[index] = todosList[index].copyWith(done: !todosList[index].done);
    prefs.setString(AppPref.todos, json.encode(todosList));
  }

  Future<List<Todo>> _getSavedTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var todoList = <Todo>[];
      final todoData = json.decode(prefs.getString(AppPref.todos) ?? "[]");
      for (var todo in todoData) {
        var t = Todo.fromJson(todo);
        todoList.add(t);
      }
      return todoList;
  }

}
