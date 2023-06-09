import 'package:car_catalog_client/models/car.dart';
import 'package:car_catalog_client/routes.dart';
import 'package:car_catalog_client/services/car_service.dart';
import 'package:flutter/material.dart';

class IndexCarPage extends StatelessWidget {
  const IndexCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Car>> cars = CarService().getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            // ícone de pincel para edição
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
          )
        ],
      ),
      body: FutureBuilder<List<Car>>(
        future: cars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao buscar dados'));
          } else {
            List<Car> cars = snapshot.data!;
            if (cars.isEmpty) {
              return const Center(
                  child: Text('Nenhum carro cadastrado',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )));
            } else {
              return ListView.separated(
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    String model = cars[index].model;
                    String brand = cars[index].brand.name;
                    String price = cars[index].price.toString();

                    return ListTile(
                      leading: Image.asset("images/car.png", width: 30),
                      title: Text("$brand $model"),
                      subtitle: Text("R\$$price"),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800]),
                        onPressed: () {
                          int carId = cars[index].id;
                          Navigator.pushNamed(context, AppRoutes.showCar,
                              arguments: {"id": carId});
                        },
                        child: const Text("Detalhes"),
                      ),
                    );
                  },
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: cars.length);
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createCar);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
