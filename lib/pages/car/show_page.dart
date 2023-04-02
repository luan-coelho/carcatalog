import 'package:flutter/material.dart';

class ShowCarPage extends StatelessWidget {
  const ShowCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carros'),
        ),
        body: const Text("Cadastro de Carro"));
  }
}
