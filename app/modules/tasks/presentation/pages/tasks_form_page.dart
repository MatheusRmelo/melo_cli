import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melo_ui/melo_ui.dart';
import '../../../../commons/injection/injection_container.dart';
import '../../domain/models/task_model.dart';
import '../manager/tasks_form/tasks_form_cubit.dart';

class TasksFormPage extends StatefulWidget {
  const TasksFormPage({super.key, this.id, required this.activeDate});
  final String? id;
  final DateTime activeDate;
  @override
  State<TasksFormPage> createState() => _TasksFormPageState();
}

class _TasksFormPageState extends State<TasksFormPage> {
  final _bloc = dependency.get<TasksFormCubit>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id == null) {
      _nameController.clear();
    } else {
      _bloc.findById(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksFormCubit, TasksFormState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is TasksFormSuccess) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
          if (state is TasksFormError) {
            ScaffoldMessenger.of(context).showSnackBar(MeloUIErrorSnackbar(
                context: context, content: Text(state.message)));
          }
          if (state is TasksFormDetailSuccess) {
            _nameController.text = state.data.name;
          }
        },
        builder: (context, state) {
          if (state is TasksFormLoading) {
            return Scaffold(
                appBar: AppBar(
                  title: MeloUIText(
                      '${widget.id != null ? 'Editar' : 'Cadastrar'} lista de compra'),
                  centerTitle: true,
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          return Scaffold(
            appBar: AppBar(
              title: MeloUIText(
                  '${widget.id != null ? 'Editar' : 'Cadastrar'} lista de compra'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MeloUIText(
                      'Selecione o dia (Opcional)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MeloUITextField(
                      label: 'Nome',
                      placeholder: 'Digite o nome do orçamento',
                      controller: _nameController,
                    ),
                    MeloUIButton(
                        title:
                            '${widget.id != null ? 'Editar' : 'Criar'} lista',
                        isLoading: (state is TasksFormBusy),
                        onPressed: () {
                          _bloc.save(TaskModel(
                              name: _nameController.text, id: widget.id));
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
