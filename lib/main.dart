import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/todo/TodoCubit.dart';
import 'package:todo_list_app/todo/TodoRepository.dart';
import 'package:todo_list_app/todo/TodoView.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoCubit(TodoRepository()),
        child: TodoView(),
      ),
    );
  }
}