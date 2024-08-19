import '../../modules/tasks/injection_container/tasks_injection_container.dart';
import 'injection_adapter.dart';

final dependency = InjectionAdapter();

Future<void> init() async {
  final TasksInjectionContainer tasksInjectionContainer =
      TasksInjectionContainer();
  tasksInjectionContainer(dependency);
}
