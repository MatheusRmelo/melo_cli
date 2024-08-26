import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/widgets/meloui_snackbar.dart';
import '../../../../commons/widgets/meloui_text_field.dart';

import '../../../../commons/injection/injection_container.dart';
import '../../../../commons/widgets/meloui_button.dart';
import '../../../../commons/widgets/meloui_text.dart';
import '../../../../commons/extensions/error_field_extension.dart';
import '../manager/authentication/authentication_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _bloc = dependency.get<AuthenticationCubit>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(MeloUiErrorSnackbar(
                context: context, content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MeloUiText(
                        "Crie sua conta no StoreList!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const MeloUiText(
                        "E faça sua lista de compras",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MeloUiTextField(
                        margin: EdgeInsets.zero,
                        label: 'Nome',
                        prefixIcon: const Icon(Icons.person),
                        placeholder: 'Digite o seu nome',
                        controller: _nameController,
                        error: state is AuthenticationErrorField
                            ? state.errors.getErrorWithCode('name')
                            : null,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      MeloUiTextField(
                        margin: EdgeInsets.zero,
                        label: 'E-mail',
                        prefixIcon: const Icon(Icons.email),
                        placeholder: 'Digite o seu e-mail',
                        controller: _emailController,
                        capitalization: TextCapitalization.none,
                        error: state is AuthenticationErrorField
                            ? state.errors.getErrorWithCode('email')
                            : null,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      MeloUiTextField(
                        margin: EdgeInsets.zero,
                        prefixIcon: const Icon(Icons.lock),
                        isPassword: true,
                        label: 'Senha',
                        placeholder: "Digite a sua senha",
                        controller: _passwordController,
                        capitalization: TextCapitalization.none,
                        error: state is AuthenticationErrorField
                            ? state.errors.getErrorWithCode('password')
                            : null,
                      ),
                      MeloUiButton(
                        margin: const EdgeInsets.only(top: 32),
                        title: 'Criar conta',
                        onPressed: () => _bloc.handleClickSignUp(
                            email: _emailController.text,
                            password: _passwordController.text),
                        isLoading: state is AuthenticationLoading,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        child: TextButton(
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushNamed(context, '/signUp');
                              }
                            },
                            child: const Text(
                              "Já tem conta? Entre agora!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      )
                    ]),
              ),
            ),
          );
        });
  }
}
