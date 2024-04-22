abstract class ITodoRepository {
  Future<void> initalSetFunc();
  Future<void> addTodo(String todoTitle, String todoDesc);
  Future<void> deleteTodo(int i);
}