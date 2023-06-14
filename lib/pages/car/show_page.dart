import 'package:car_catalog_client/models/car.dart';
import 'package:car_catalog_client/routes.dart';
import 'package:car_catalog_client/services/car_service.dart';
import 'package:flutter/material.dart';

class ShowCarPage extends StatelessWidget {
  const ShowCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final int id = arguments['id'];

    Future<Car> carResponse = CarService().getById(id);

    void handleDelete(int id) {
      CarService().deleteById(id).then((value) {
        if (value) {
          final snackBar = SnackBar(
            content: const Text('Carro deletado com sucesso!'),
            action: SnackBarAction(
              textColor: Colors.green,
              onPressed: () {},
              label: '',
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.cars, (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<Car>(
              future: carResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao buscar dados'));
                } else {
                  Car car = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 30),
                        child: Image.asset("images/car2.png", width: 200),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Modelo',
                            prefixIcon: Icon(Icons.directions_car),
                          ),
                          focusNode: FocusNode(),
                          enabled: false,
                          initialValue: car.model,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ano',
                            prefixIcon: Icon(Icons.calendar_month),
                          ),
                          focusNode: FocusNode(),
                          enabled: false,
                          initialValue: car.year.toString(),
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Marca',
                            prefixIcon: Icon(Icons.build_circle),
                          ),
                          focusNode: FocusNode(),
                          enabled: false,
                          initialValue: car.brand.name,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Categoria',
                            prefixIcon: Icon(Icons.category),
                          ),
                          focusNode: FocusNode(),
                          enabled: false,
                          initialValue: car.category.name,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tipo de Combustível',
                            prefixIcon: Icon(Icons.local_gas_station),
                          ),
                          focusNode: FocusNode(),
                          enabled: false,
                          initialValue: car.fuelType.name,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Preço',
                            prefixIcon: Icon(Icons.price_change),
                          ),
                          focusNode: FocusNode(),
                          enabled: false,
                          initialValue: car.price.toString(),
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Descrição',
                            prefixIcon: Icon(Icons.price_change),
                          ),
                          focusNode: FocusNode(),
                          enabled: false,
                          initialValue: car.description,
                          readOnly: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800]),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.editCar,
                                  arguments: {"id": id});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.edit),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    'Editar',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10, height: 70),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[800]),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Confirmaçao'),
                                content: const Text(
                                    'Voce tem certeza que deseja excluir este registro?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => {
                                      Navigator.pop(context, 'Cancel'),
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () => handleDelete(id),
                                    child: const Text('Confirmar'),
                                  ),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.delete),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    'Deletar',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }
              }),
        )));
  }
}
