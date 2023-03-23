import 'package:flutter/material.dart';
import 'package:fruit_salad/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() {
    return _FormRegisterState();
  }
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adresse email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Merci de renseigner une adresse mail';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Mot de passe',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Merci de renseigner un mot de passe';
                }
                return null;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .setShowRegisterForm(false);
                },
                child: const Text('Connexion'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await Provider.of<UserProvider>(context, listen: false)
                          .signinUser(
                        emailController.text,
                        passwordController.text,
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Compte crée !')),
                      );
                    } catch (excpetion) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Une erreur est survenue')),
                      );
                    }
                  }
                },
                child: const Text('S\'inscrire'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
