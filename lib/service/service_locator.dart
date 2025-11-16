import 'package:get_it/get_it.dart';
import 'package:todo_isar/service/task_service.dart';
import 'package:todo_isar/ui/cubit/task_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Register TaskService as a singleton

  getIt.registerLazySingleton<TaskService>(() => TaskService());

  // initialize taskService

  await getIt<TaskService>().init();

// Register taskcubit as factory (new instane every time)

  getIt.registerFactory(() => TasksCubit(getIt<TaskService>()));
}
