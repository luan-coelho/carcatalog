import 'package:carshop/models/car.dart';
import 'package:carshop/routes.dart';
import 'package:carshop/services/car_service.dart';
import 'package:flutter/material.dart';

class IndexCarPage extends StatelessWidget {
  const IndexCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Car>> cars = CarService().getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
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
            return ListView.separated(
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  String model = cars[index].model;
                  String brand = cars[index].brand.name;

                  return ListTile(
                    leading: Image.asset("images/car.png", width: 30),
                    title: Text("$brand $model"),
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[800],
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createCar);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
