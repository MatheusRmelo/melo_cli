import '../../../../core/navigation/domain/mixins/navigation_route.dart';
import '../../../../core/navigation/domain/models/route_model.dart';
import '../pages/users_form_page.dart';
import '../pages/users_page.dart';

class UsersRoutes with NavigationRoute {
  @override
  String get prefix => "/users";
  @override
  List<RouteModel> get routes => [
        RouteModel(path: '/', child: (args) => const UsersPage()),
        RouteModel(
          path: '/create',
          child: (args) => const UsersFormPage(),
        ),
        RouteModel(
          path: '/edit/:id',
          child: (args) => UsersFormPage(
            id: args!['id'],
          ),
        ),
      ];

  final bool authenticated = true;
  bool checkPermissions() => true;
}
