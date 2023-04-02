import 'package:carshop/models/car.dart';
import 'package:carshop/routes.dart';
import 'package:carshop/services/car_service.dart';
import 'package:flutter/material.dart';

class IndexCarPage extends StatelessWidget {
  const IndexCarPage({super.key});

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
                  return Card(
                      margin: const EdgeInsets.only(
                          top: 15.0, left: 12.0, right: 12.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.car_crash),
                              title: Text(car.model),
                              subtitle: Text(car.brand.name),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(car.price.toString()),
                                  const SizedBox(width: 8),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('VISUALIZAR'),
                                    onPressed: () {
                                      Navigator.pushNamed(context, AppRoutes.showCar);
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ])
                          ]));
                },
              );
            }
          },
        ));
  }
}
