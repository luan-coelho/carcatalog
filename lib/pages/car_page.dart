import 'package:carshop/models/car.dart';
import 'package:carshop/services/car_service.dart';
import 'package:flutter/material.dart';

class CarPage extends StatelessWidget {
  const CarPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Car>> cars = CarService().getAllCars();

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
              return ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  Car car = cars[index];
                  return ListTile(title: Text('${car.make} ${car.model}'));
                },
              );
            }
          },
        ));
  }
}
