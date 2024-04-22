import 'package:bloc/bloc.dart';
import 'package:todo_list_app/features/todo/data/TodoRepository.dart';
import 'package:todo_list_app/features/todo/domain/repository/ITodoRepository.dart';
import 'package:todo_list_app/features/todo/presentation/bloc/TodoState.dart';

class TodoCubit extends Cubit<TodoState> {
  // ignore: unused_field
  final ITodoRepository _todoRepository;

  TodoCubit(this._todoRepository) : super(TodoInitial());

  Future<void> initial() async {
    try {
      emit(const TodoLoading());
      final todoList = await _todoRepository.initialSetFunc();
      emit(TodoLoaded(todoList));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> add(String todoTitle, todoDescription) async {
    try {
      emit(const TodoLoading());
      await _todoRepository.addTodo(todoTitle, todoDescription);
      final todoList = await _todoRepository.initialSetFunc();
      emit(TodoLoaded(todoList));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete(int i) async {
    try {
      emit(const TodoLoading());
      await _todoRepository.deleteTodo(i);
      final todoList = await _todoRepository.initialSetFunc();
      emit(TodoLoaded(todoList));
    } catch (e) {
      throw Exception(e);
    }
  }

  void toggleDone(int i) async{
    try {
      emit(const TodoLoading());
      await _todoRepository.toggleDone(i);
      final todoList = await _todoRepository.initialSetFunc();
      emit(TodoLoaded(todoList));
    } catch (e) {
      throw Exception(e);
    }
  }
}
