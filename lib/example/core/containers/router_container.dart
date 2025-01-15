import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../modules/users/routes/users_router_container.dart' as users;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final getRoutes = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    ...users.getRouterContainer,
  ],
);
