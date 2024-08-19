import '../../../commons/injection/injection_adapter.dart';
import '../data/data_sources/tasks_remote_datasource.dart';
import '../data/repositories/tasks_repository.dart';
import '../domain/repositories/i_tasks_repository.dart';
import '../domain/use_cases/create_task_usecase.dart';
import '../domain/use_cases/delete_task_usecase.dart';
import '../domain/use_cases/detail_task_usecase.dart';
import '../domain/use_cases/list_task_usecase.dart';
import '../domain/use_cases/update_task_usecase.dart';
import '../presentation/manager/tasks/tasks_cubit.dart';
import '../presentation/manager/tasks_form/tasks_form_cubit.dart';

class TasksInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<ITasksRemoteDataSource>(
      () => TasksRemoteDataSource(),
    );

    dependency.registerFactory<ITasksListRepository>(
      () => TasksRepository(
        remoteDataSource: dependency.get<ITasksRemoteDataSource>(),
      ),
    );

    dependency.registerFactory<ListTaskUsecase>(
      () => ListTaskUsecase(repository: dependency.get<ITasksListRepository>()),
    );

    dependency.registerFactory<DeleteTaskUsecase>(
      () =>
          DeleteTaskUsecase(repository: dependency.get<ITasksListRepository>()),
    );

    dependency.registerFactory<DetailTaskUsecase>(
      () =>
          DetailTaskUsecase(repository: dependency.get<ITasksListRepository>()),
    );

    dependency.registerFactory<UpdateTaskUsecase>(
      () =>
          UpdateTaskUsecase(repository: dependency.get<ITasksListRepository>()),
    );

    dependency.registerFactory<CreateTaskUsecase>(
      () =>
          CreateTaskUsecase(repository: dependency.get<ITasksListRepository>()),
    );

    dependency.registerFactory<TasksCubit>(
      () => TasksCubit(
          deleteTaskUsecase: dependency.get<DeleteTaskUsecase>(),
          listTaskUsecase: dependency.get<ListTaskUsecase>()),
    );

    dependency.registerFactory<TasksFormCubit>(
      () => TasksFormCubit(
        detailTaskUsecase: dependency.get<DetailTaskUsecase>(),
        updateTaskUsecase: dependency.get<UpdateTaskUsecase>(),
        createTaskUsecase: dependency.get<CreateTaskUsecase>(),
      ),
    );
  }
}
