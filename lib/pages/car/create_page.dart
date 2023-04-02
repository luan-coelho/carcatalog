import 'package:flutter/material.dart';

class CreateCarPage extends StatelessWidget {
  const CreateCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar'),
        ),
        body: const Text("Cadastro de Carro"));
  }
}
