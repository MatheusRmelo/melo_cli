import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melo_cli/example/commons/models/response.dart';

import '../../../domain/models/task_model.dart';
import '../../../domain/use_cases/delete_task_usecase.dart';
import '../../../domain/use_cases/list_task_usecase.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final ListTaskUsecase listTaskUsecase;
  final DeleteTaskUsecase deleteTaskUsecase;
  TasksCubit({required this.listTaskUsecase, required this.deleteTaskUsecase})
      : super(TasksInitial());

  Future<void> findAll() async {
    emit(TasksLoading());
    var response = await listTaskUsecase.call();
    if (response is ErrorResponse) {
      emit(TasksError((response.response as ErrorResponse).error));
    } else {
      emit(TasksSuccess(response.result!));
    }
  }

  Future<void> delete(String id) async {
    emit(TasksLoading());
    var response = await deleteTaskUsecase.call(id);
    if (response is ErrorResponse) {
      emit(TasksError((response.response as ErrorResponse).error));
    } else {
      findAll();
    }
  }
}
