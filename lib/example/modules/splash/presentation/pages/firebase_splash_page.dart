import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../commons/extensions/context_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((data) {
      changeUser();
    });
  }

  void changeUser() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      context.pushReplacementNamed('sign-in');
    } else {
      context.pushReplacementNamed('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.isMobile ? Colors.white : null,
          elevation: context.isMobile ? 0 : null,
        ),
        body: const Center(
          child: Text('Carregando...'),
        ));
  }
}
