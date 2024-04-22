import 'package:todo_list_app/features/todo/domain/model/Todo.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

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
      body: BlocBuilder<TodoCubit, TodoState>(
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

  FloatingActionButton addButton(
    BuildContext context,
  ) {
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
                onAdd: (title, description) async{
                  final todoCubit = BlocProvider.of<TodoCubit>(context);
                  await todoCubit.add(title, description);
                  if (todoCubit.state is TodoLoaded) {
                    _listKey.currentState?.insertItem(
                        (todoCubit.state as TodoLoaded).todo.length - 1);
                  }
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
    return AnimatedList(
        key: _listKey,
        initialItemCount: state.todo.length,
        itemBuilder: (context, index, animation) {
          final item = state.todo[index];
          return _buildItem(item, index, animation);
        });
  }

  Widget _buildItem(Todo item, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: TaskView(
          index: index,
          todo: item,
          onDelete: () async {
            await BlocProvider.of<TodoCubit>(context).delete(index);
            _listKey.currentState?.removeItem(
              index,
              (context, animation) {
                return _buildItem(item, index, animation); // Animate removal
              },
            );
          }),
    );
  }
}
