import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarAvatarNotification extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarAvatarNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: CircleAvatar(
        child: Image.network(
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          width: 32,
          height: 32,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              context.pushNamed('notifications');
            },
            icon: const Icon(Icons.notifications))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
