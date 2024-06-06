import 'package:flutter/material.dart';

class PreLogin extends StatefulWidget {
  const PreLogin({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<PreLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email: $email, Password: $password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un e-mail';
                      } else if (!_isValidEmail(value)) {
                        return 'Veuillez renseigner un e-mail valide';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Mot de Passe sécurisé'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un mot de passe';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Envoyer'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'lib/assets/images/joinus.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp( MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Rejoignez la communauté (RE)SOURCES Relationnelles'),
      ),
      body: const PreLogin(),
    ),
  ));
}
