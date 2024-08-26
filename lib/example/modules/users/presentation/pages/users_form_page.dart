import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/injection/injection_container.dart';
import '../../../../commons/widgets/meloui_button.dart';
import '../../../../commons/widgets/meloui_snackbar.dart';
import '../../../../commons/widgets/meloui_text.dart';
import '../../../../commons/widgets/meloui_text_field.dart';
import '../../domain/models/user_model.dart';
import '../manager/users_form/users_form_cubit.dart';

class UsersFormPage extends StatefulWidget {
  const UsersFormPage({super.key, this.id, required this.activeDate});
  final String? id;
  final DateTime activeDate;
  @override
  State<UsersFormPage> createState() => _UsersFormPageState();
}

class _UsersFormPageState extends State<UsersFormPage> {
  final _bloc = dependency.get<UsersFormCubit>();
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
    return BlocConsumer<UsersFormCubit, UsersFormState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is UsersFormSuccess) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
          if (state is UsersFormError) {
            ScaffoldMessenger.of(context).showSnackBar(MeloUiErrorSnackbar(
                context: context, content: Text(state.message)));
          }
          if (state is UsersFormDetailSuccess) {
            _nameController.text = state.data.name;
          }
        },
        builder: (context, state) {
          if (state is UsersFormLoading) {
            return Scaffold(
                appBar: AppBar(
                  title: MeloUiText(
                      '${widget.id != null ? 'Editar' : 'Cadastrar'} lista de compra'),
                  centerTitle: true,
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          return Scaffold(
            appBar: AppBar(
              title: MeloUiText(
                  '${widget.id != null ? 'Editar' : 'Cadastrar'} lista de compra'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MeloUiText(
                      'Selecione o dia (Opcional)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MeloUiTextField(
                      label: 'Nome',
                      placeholder: 'Digite o nome do orçamento',
                      controller: _nameController,
                    ),
                    MeloUiButton(
                        title:
                            '${widget.id != null ? 'Editar' : 'Criar'} lista',
                        isLoading: (state is UsersFormBusy),
                        onPressed: () {
                          _bloc.save(UserModel(
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
