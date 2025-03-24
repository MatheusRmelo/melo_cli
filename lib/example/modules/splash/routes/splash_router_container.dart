import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/containers/injection_container.dart';

import '../presentation/manager/splash/splash_cubit.dart';
import '../presentation/pages/splash_page.dart';

final getRouterContainer = [
  GoRoute(
    path: '/',
    name: 'splash',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<SplashCubit>(
          create: (context) => dependency.get<SplashCubit>(),
          child: const SplashPage(),
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
];
