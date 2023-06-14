import 'dart:async';

import 'package:car_catalog_client/models/brand.dart';
import 'package:car_catalog_client/models/car.dart';
import 'package:car_catalog_client/models/category.dart';
import 'package:car_catalog_client/models/fueltype.dart';
import 'package:car_catalog_client/routes.dart';
import 'package:car_catalog_client/services/brand_service.dart';
import 'package:car_catalog_client/services/car_service.dart';
import 'package:car_catalog_client/services/category_service.dart';
import 'package:car_catalog_client/services/fueltype_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateCarPage extends StatefulWidget {
  const CreateCarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateCarPageState();
}

class _CreateCarPageState extends State<CreateCarPage> {
  final form = GlobalKey<FormState>();

  void submitForm() {
    bool? validate = form.currentState?.validate();
    if (!validate!) {
      return;
    }

    Car car = Car(
        model: model.value.text,
        year: int.parse(year.value.text),
        fuelType: selectedFuelType!,
        price: double.parse(price.value.text),
        description: description.value.text,
        brand: selectedBrand!,
        category: selectedCategory!);

    CarService().create(car).then((value) {
      if (value) {
        final snackBar = SnackBar(
          content: const Text('Carro cadastrado com sucesso!'),
          action: SnackBarAction(
            textColor: Colors.green,
            onPressed: () {},
            label: '',
          ),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.cars);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  late Future<List<FuelType>> futureFuelType;
  FuelType? selectedFuelType;

  late Future<List<Brand>> futureBrands;
  Brand? selectedBrand;

  late Future<List<Category>> futureCategories;
  Category? selectedCategory;

  final model = TextEditingController();
  final year = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureFuelType = FuelTypeService().getAll();
    futureBrands = BrandService().getAll();
    futureCategories = CategoryService().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar carro'),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 30),
                      child: Image.asset("images/car2.png", width: 200),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: model,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Modelo',
                          prefixIcon: Icon(Icons.directions_car),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o modelo';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: year,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 4,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          labelText: 'Ano',
                          prefixIcon: Icon(Icons.calendar_month),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o ano';
                          }

                          if (value.length < 3) {
                            return 'Informe 4 digitos para o ano';
                          }

                          if (value.length == 4) {
                            try {
                              int yearValue = int.parse(value);
                              int currentYear = DateTime.now().year + 1;
                              if (yearValue < 1940 || yearValue > currentYear) {
                                return 'Informe um ano superior a 1940 e inferior a $currentYear';
                              }
                            } catch (e) {
                              return 'Informe um ano válido';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    FutureBuilder<List<Brand>>(
                        future: futureBrands,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Erro ao buscar dados'));
                          } else {
                            List<Brand> brands = snapshot.data!;
                            return DropdownButtonFormField<Brand>(
                              value: selectedBrand,
                              hint: const Text('Selecione uma marca'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.build_circle),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Informe a marca';
                                }
                                return null;
                              },
                              isExpanded: true,
                              elevation: 24,
                              onChanged: (Brand? value) {
                                setState(() {
                                  selectedBrand = value!;
                                });
                              },
                              items: brands
                                  .map<DropdownMenuItem<Brand>>((Brand value) {
                                return DropdownMenuItem<Brand>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            );
                          }
                        }),
                    FutureBuilder<List<Category>>(
                        future: futureCategories,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Erro ao buscar dados'));
                          } else {
                            List<Category> categories = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: DropdownButtonFormField<Category>(
                                value: selectedCategory,
                                hint: const Text('Selecione uma categoria'),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.category),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Informe a categoria';
                                  }
                                  return null;
                                },
                                isExpanded: true,
                                elevation: 24,
                                onChanged: (Category? value) {
                                  setState(() {
                                    selectedCategory = value!;
                                  });
                                },
                                items: categories
                                    .map<DropdownMenuItem<Category>>(
                                        (Category value) {
                                  return DropdownMenuItem<Category>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        }),
                    FutureBuilder<List<FuelType>>(
                        future: futureFuelType,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Erro ao buscar dados'));
                          } else {
                            List<FuelType> fuelTypes = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: DropdownButtonFormField<FuelType>(
                                value: selectedFuelType,
                                hint: const Text(
                                    'Selecione um tipo de combustível'),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.local_gas_station),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Informe um tipo de combustível';
                                  }
                                  return null;
                                },
                                isExpanded: true,
                                elevation: 24,
                                onChanged: (FuelType? value) {
                                  setState(() {
                                    selectedFuelType = value!;
                                  });
                                },
                                items: fuelTypes
                                    .map<DropdownMenuItem<FuelType>>(
                                        (FuelType value) {
                                  return DropdownMenuItem<FuelType>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Preço',
                          prefixIcon: Icon(Icons.price_change),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o preço';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: description,
                        maxLines: null,
                        maxLength: 255,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descrição',
                          prefixIcon: Icon(Icons.price_change),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe a descrição';
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
                            backgroundColor: Colors.green[800]),
                        onPressed: () => submitForm(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
