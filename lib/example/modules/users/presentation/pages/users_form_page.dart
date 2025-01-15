import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../commons/extensions/list_dynamic_field_extension.dart';
import '../../../../commons/models/dynamic_field_model.dart';
import '../../../../commons/widgets/custom_button.dart';
import '../../../../commons/widgets/dynamic_form/dynamic_form_widget.dart';
import '../../../../commons/widgets/sidebar/sidebar.dart';
import '../../../../commons/widgets/custom_snackbar.dart';
import '../../../../commons/widgets/custom_text.dart';

import '../../../../core/containers/injection_container.dart';
import '../../domain/models/user_model.dart';
import '../manager/users_form/users_form_cubit.dart';

class UsersFormPage extends StatefulWidget {
  const UsersFormPage({super.key, this.id});
  final String? id;

  @override
  State<UsersFormPage> createState() => _UsersFormPageState();
}

class _UsersFormPageState extends State<UsersFormPage> {
  final _bloc = dependency.get<UsersFormCubit>();
  List<DynamicFieldModel> _fields = [];

  @override
  void initState() {
    super.initState();
    _fields = _bloc.getFields();
    if (widget.id == null) {
      _fields = _fields.clearFields();
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
            if (context.canPop()) {
              context.pop(true);
            }
          }
          if (state is UsersFormError) {
            ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(context: context, content: Text(state.message)));
          }
          if (state is UsersFormDetailSuccess) {
            _fields = _fields.fromJson(state.data.toJson());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Row(
              children: [
                const Sidebar(
                  width: 300,
                ),
                Expanded(
                  child: state is UsersFormLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (context.canPop()) {
                                          context.pop();
                                        } else {
                                          context.replaceNamed('get-users');
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        size: 32,
                                      )),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  CustomText(
                                    '${widget.id != null ? 'Editar' : 'Criar'} usuário',
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DynamicFormWidget(
                                          onChangedField: (index, value) {
                                            setState(() {
                                              _fields[index].value =
                                                  value.value;
                                            });
                                          },
                                          fields: _fields),
                                      CustomButton(
                                          width: 200,
                                          title:
                                              '${widget.id != null ? 'Editar' : 'Criar'} usuário',
                                          isLoading: (state is UsersFormBusy),
                                          onPressed: () async {
                                            _bloc.save(
                                                UserModel.fromJsonForm(
                                                    await _fields.toJson()),
                                                id: widget.id);
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
