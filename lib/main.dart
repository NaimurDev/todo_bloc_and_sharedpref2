import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/constants.dart';
import 'package:todo_list_app/di_module.dart';
import 'package:todo_list_app/features/todo/domain/repository/ITodoRepository.dart';
import 'package:todo_list_app/features/todo/presentation/bloc/TodoCubit.dart';
import 'package:todo_list_app/features/todo/presentation/TodoView.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const TodoApp());
}
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConst.appName,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoCubit(di<ITodoRepository>()),
        child: const TodoView(),
      ),
    );
  }
}