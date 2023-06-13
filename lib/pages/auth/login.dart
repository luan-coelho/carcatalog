import 'package:car_catalog_client/routes.dart';
import 'package:car_catalog_client/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    final form = GlobalKey<FormState>();
    final login = TextEditingController();
    final password = TextEditingController();

    void submitForm() {
      bool? validate = form.currentState?.validate();
      if (!validate!) {
        return;
      }

      if (authService.validateLogin(login.text, password.text)) {
        Navigator.pushReplacementNamed(context, AppRoutes.cars);
      } else {
        final snackBar = SnackBar(
          content: const Text('Login ou senha inválidos'),
          action: SnackBarAction(
            textColor: Colors.green,
            onPressed: () {},
            label: '',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: form,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 30),
            child: Image.asset("images/carstore.png", width: 200),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: login,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                labelText: 'Login',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe o login';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                labelText: 'Senha',
                prefixIcon: Icon(Icons.key),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe a senha';
                }
                return null;
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 12),
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
              onPressed: () => submitForm(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
