abstract class ITodoRepository {
  Future<void> initialSetFunc();
  Future<void> addTodo(String todoTitle, String todoDesc);
  Future<void> deleteTodo(int i);
  Future<void> toggleDone(int index);
}