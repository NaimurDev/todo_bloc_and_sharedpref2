import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/constants.dart';
import 'package:todo_list_app/features/todo/presentation/bloc/TodoCubit.dart';
import 'package:todo_list_app/features/todo/data/TodoRepository.dart';
import 'package:todo_list_app/features/todo/presentation/TodoView.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConst.appName,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoCubit(TodoRepository()),
        child: TodoView(),
      ),
    );
  }
}