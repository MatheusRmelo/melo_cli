part of 'tasks_cubit.dart';

sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksSuccess extends TasksState {
  final List<TaskModel> data;
  TasksSuccess(this.data);
}

final class TasksError extends TasksState {
  final String message;
  TasksError(this.message);
}
