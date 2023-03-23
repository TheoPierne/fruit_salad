import 'package:flutter/material.dart';
import 'package:fruit_salad/providers/UserProvider.dart';
import 'package:fruit_salad/user.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() {
    return _UserProfileState();
  }
}

class _UserProfileState extends State<UserProfile> {
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input.toLowerCase())).toString();
  }

  String generateGravatarLink(User user) {
    final String hash = generateMd5(user.email);
    return "https://www.gravatar.com/avatar/$hash?d=identicon";
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                  generateGravatarLink(userProvider.currentUser!),
                ),
              ),
              Text(
                userProvider.currentUser!.email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false)
                  .setConnectedState(false);
              Provider.of<UserProvider>(context, listen: false)
                  .setShowRegisterForm(true);
              Provider.of<UserProvider>(context, listen: false)
                  .setCurrentUser(null);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
            ),
            child: const Text('Se déconnecter'),
          ),
        ),
      ],
    );
  }
}
