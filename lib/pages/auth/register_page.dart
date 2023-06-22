import 'package:car_catalog_client/dto/register_request.dart';
import 'package:car_catalog_client/routes.dart';
import 'package:car_catalog_client/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    final form = GlobalKey<FormState>();
    final name = TextEditingController();
    final login = TextEditingController();
    final password = TextEditingController();

    void submitForm() {
      bool? validate = form.currentState?.validate();
      if (!validate!) {
        return;
      }

      RegisterRequest request =
          RegisterRequest(name.text, login.text, password.text);
      authService.register(request).then((value) {
        String message = "Aconteceu algo inesperado. Tente mais tarde";
        if (value) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          message = "Cadastrado realizado com sucesso. Faça seu login";
        }
        final snackBar = SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            textColor: Colors.black,
            onPressed: () {},
            label: '',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: login,
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                  prefixIcon: Icon(Icons.email),
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
                    Icon(Icons.app_registration),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Cadastrar',
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
                onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
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
      ),
    ));
  }
}
