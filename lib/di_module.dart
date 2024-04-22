import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/features/todo/data/TodoRepository.dart';
import 'package:todo_list_app/features/todo/domain/repository/ITodoRepository.dart';

final GetIt di = GetIt.instance;

Future<void> initDI() async {
  // Setup SharedPreferences
  SharedPreferences pref = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(pref);

  di.registerSingleton<ITodoRepository>(
    TodoRepository(localStore: di<SharedPreferences>()),
  );
}
