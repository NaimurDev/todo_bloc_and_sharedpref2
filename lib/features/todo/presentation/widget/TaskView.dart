import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/features/todo/domain/model/Todo.dart';
import 'package:todo_list_app/features/todo/presentation/bloc/TodoCubit.dart';

class TaskView extends StatelessWidget {
  final int index;
  final Todo todo;
  const TaskView({super.key, required this.index, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.done,
        onChanged: (value) {
          BlocProvider.of<TodoCubit>(context).toggleDone(index);
        },
      ),
      title: Text(
        todo.title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              decoration:
                  todo.done ? TextDecoration.lineThrough : TextDecoration.none,
            ),
      ),
      subtitle: Text(
        todo.description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              decoration:
                  todo.done ? TextDecoration.lineThrough : TextDecoration.none,
            ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
        ),
        color: Colors.red,
        onPressed: () {
          BlocProvider.of<TodoCubit>(context).delete(index);
        },
      ),
    );
  }
}
