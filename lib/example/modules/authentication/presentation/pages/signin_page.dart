import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commons/widgets/meloui_snackbar.dart';
import '../../../../commons/widgets/meloui_text_field.dart';

import '../../../../commons/injection/injection_container.dart';
import '../manager/authentication/authentication_cubit.dart';
import '../../../../commons/widgets/meloui_button.dart';
import '../../../../commons/widgets/meloui_text.dart';
import '../../../../commons/extensions/error_field_extension.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _bloc = dependency.get<AuthenticationCubit>();
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
                        "Bem vindo!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const MeloUiText(
                        "Entre agora e aproveite",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MeloUiTextField(
                        margin: EdgeInsets.zero,
                        label: 'E-mail',
                        prefixIcon: const Icon(Icons.email),
                        placeholder: 'Digite o seu e-mail',
                        controller: _emailController,
                        error: state is AuthenticationErrorField
                            ? state.errors.getErrorWithCode('email')
                            : null,
                        capitalization: TextCapitalization.none,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Esqueci minha senha",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      MeloUiButton(
                        margin: const EdgeInsets.only(top: 8),
                        title: 'Entrar',
                        onPressed: () => _bloc.handleClickSignIn(
                            email: _emailController.text,
                            password: _passwordController.text),
                        isLoading: state is AuthenticationLoading,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              "Não tem conta ainda? Crie uma agora!",
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
