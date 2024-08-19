import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/models/response.dart';
import '../../../domain/models/task_model.dart';
import '../../../domain/use_cases/create_task_usecase.dart';
import '../../../domain/use_cases/detail_task_usecase.dart';
import '../../../domain/use_cases/update_task_usecase.dart';

part 'tasks_form_state.dart';

class TasksFormCubit extends Cubit<TasksFormState> {
  final DetailTaskUsecase detailTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;
  final CreateTaskUsecase createTaskUsecase;

  TasksFormCubit(
      {required this.detailTaskUsecase,
      required this.updateTaskUsecase,
      required this.createTaskUsecase})
      : super(TasksFormInitial());

  Future<void> findById(String id) async {
    emit(TasksFormLoading());
    var data = await detailTaskUsecase.call(id);
    if (data!.response is Success) {
      emit(TasksFormDetailSuccess(data.result!));
    } else if (data.response is ErrorResponse) {
      emit(TasksFormError((data.response as ErrorResponse).error));
    }
  }

  Future<void> save(TaskModel body) async {
    emit(TasksFormBusy());
    Response response = Success();
    if (body.id != null) {
      response = (await updateTaskUsecase.call(body.id!, body)).response;
    } else {
      response = (await createTaskUsecase.call(body)).response;
    }

    if (response is Success) {
      emit(TasksFormSuccess());
    } else if (response is ErrorResponse) {
      emit(TasksFormError(response.error));
    }
  }
}
