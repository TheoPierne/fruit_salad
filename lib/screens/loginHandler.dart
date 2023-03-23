import 'package:flutter/material.dart';
import 'package:fruit_salad/providers/UserProvider.dart';
import 'package:fruit_salad/screens/formRegister.dart';
import 'package:fruit_salad/screens/formSignin.dart';
import 'package:fruit_salad/screens/userProfile.dart';
import 'package:provider/provider.dart';

class LoginHandler extends StatefulWidget {
  const LoginHandler({super.key});

  @override
  State<LoginHandler> createState() {
    return _LoginHandlerState();
  }
}

class _LoginHandlerState extends State<LoginHandler> {
  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    return Column(
      children: [
        Visibility(
          visible: !userProvider.isConnected && !userProvider.showRegisterForm,
          child: const FormSignin(),
        ),
        Visibility(
          visible: !userProvider.isConnected && userProvider.showRegisterForm,
          child: const FormRegister(),
        ),
        Visibility(
          visible: userProvider.isConnected,
          child: const UserProfile(),
        ),
      ],
    );
  }
}
