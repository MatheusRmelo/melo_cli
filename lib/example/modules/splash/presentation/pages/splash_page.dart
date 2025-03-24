import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../commons/extensions/context_extension.dart';
import '../../../../commons/widgets/custom_snackbar.dart';

import '../../../../core/containers/injection_container.dart';
import '../manager/splash/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _bloc = dependency.get<SplashCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.checkIsLogged();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is SplashError) {
            ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(context: context, content: Text(state.message)));
          }
          if (state is SplashSuccess) {
            if (state.isLogged) {
              context.pushReplacementNamed('home');
            } else {
              context.pushReplacementNamed('sign-in');
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: context.isMobile ? Colors.white : null,
                elevation: context.isMobile ? 0 : null,
              ),
              body: const Center(
                child: Text('Carregando...'),
              ));
        });
  }
}
