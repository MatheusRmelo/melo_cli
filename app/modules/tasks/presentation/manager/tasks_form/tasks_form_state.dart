part of 'tasks_form_cubit.dart';

sealed class TasksFormState {}

final class TasksFormInitial extends TasksFormState {}

final class TasksFormLoading extends TasksFormState {}

final class TasksFormBusy extends TasksFormState {}

final class TasksFormDetailSuccess extends TasksFormState {
  final TaskModel data;
  TasksFormDetailSuccess(this.data);
}

final class TasksFormSuccess extends TasksFormState {
  TasksFormSuccess();
}

final class TasksFormError extends TasksFormState {
  final String message;
  TasksFormError(this.message);
}
