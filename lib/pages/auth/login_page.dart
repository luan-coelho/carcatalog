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

      authService.validateLogin(login.text, password.text).then((value) {
        if (value) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.cars, (route) => false);
        } else {
          final snackBar = SnackBar(
            content: const Text('Login ou senha inválidos'),
            backgroundColor: Colors.redAccent,
            action: SnackBarAction(
              textColor: Colors.black,
              onPressed: () {},
              label: '',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 44),
              child: Image.asset("images/login.jpg", width: 200),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text(
                'Seja bem-vindo',
                style: TextStyle(
                  fontSize: 40, // Tamanho da fonte
                  fontWeight: FontWeight.bold, // Fonte em negrito
                  color: Colors.black, // Cor do texto
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: login,
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  labelText: 'Logar',
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[500]),
                onPressed: () => submitForm(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Logar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 12),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[500]),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.register),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.app_registration),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Cadastro',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
