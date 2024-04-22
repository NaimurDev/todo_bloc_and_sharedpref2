import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/features/todo/domain/model/Todo.dart';
import 'package:todo_list_app/features/todo/domain/repository/ITodoRepository.dart';

import 'unit_test.mocks.dart';

class TodoRepoTest extends Mock implements ITodoRepository {}

@GenerateMocks([TodoRepoTest])
Future<void> main() async{
  late MockTodoRepoTest mockTodoRepoTest;

  setUpAll(() {
    mockTodoRepoTest = MockTodoRepoTest();
  });

  test("Adding Todo Item", () async{
    Todo todo = Todo(
      title: "Test",
      description: "Test Description",
    );

    when(mockTodoRepoTest.addTodo(
      todo.title,
      todo.description,
    )).thenAnswer((_) async => true);

    when(mockTodoRepoTest.initialSetFunc()).thenAnswer((_) async => [todo]);

    await mockTodoRepoTest.addTodo(
      todo.title,
      todo.description,
    );

    var todos = await mockTodoRepoTest.initialSetFunc();

    expect(todos.length, 1);
  });
}