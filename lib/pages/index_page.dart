import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Car Shop - Venda de Carros'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(Colors.black54.value)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/cars");
                },
                child: const Text('Ir para listagem de carros'),
              ),
            )
          ],
        ));
  }
}
