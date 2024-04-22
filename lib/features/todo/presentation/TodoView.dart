import 'package:todo_list_app/features/todo/presentation/bloc/TodoCubit.dart';
import 'package:todo_list_app/features/todo/presentation/bloc/TodoState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/features/todo/presentation/widget/AddTodoBottomSheet.dart';
import 'package:todo_list_app/features/todo/presentation/widget/TaskView.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  var tfTodo = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoCubit>(context).initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDos'),
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TodoInitial) {
            return initialView();
          }
          if (state is TodoLoading) {
            return const CircularProgressIndicator();
          }
          if (state is TodoLoaded) {
            return loadedView(state);
          } else {
            return errorView();
          }
        },
      ),
      floatingActionButton: addButton(context),
    );
  }

  FloatingActionButton addButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_context) {
            return Padding(
              padding: MediaQuery.of(_context).viewInsets,
              child: AddTodoBottomSheet(
                onAdd: (title, description) {
                  BlocProvider.of<TodoCubit>(context).add(title, description);
                },
              ),
            );
          },
        );
      },
    );
  }

  Center initialView() {
    return const Center(
      child: Text("inital"),
    );
  }

  Center errorView() {
    return const Center(
      child: Text("ERROR"),
    );
  }

  Widget loadedView(TodoLoaded state) {
    return ListView.builder(
      itemCount: state.todo.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskView(index: index, todo: state.todo[index]);
      },
    );
  }
}
