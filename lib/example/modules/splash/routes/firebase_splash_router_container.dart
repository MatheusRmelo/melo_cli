import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/splash_page.dart';

final getRouterContainer = [
  GoRoute(
    path: '/',
    name: 'splash',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const SplashPage(),
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
