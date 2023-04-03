import 'package:carshop/models/car.dart';
import 'package:carshop/services/car_service.dart';
import 'package:flutter/material.dart';

class ShowCarPage extends StatelessWidget {
  const ShowCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int id = arguments['id'];

    Future<Car> carResponse = CarService().getById(id);

    return Scaffold(
        appBar: AppBar(
            title: FutureBuilder(
                future: carResponse,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Car car = snapshot.data!;
                    return Text(car.model);
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return const CircularProgressIndicator();
                  }
                })),
        body: FutureBuilder<Car>(
            future: carResponse,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao buscar dados'));
              } else {
                Car car = snapshot.data!;
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
                        ]));
              }
            }));
  }
}
