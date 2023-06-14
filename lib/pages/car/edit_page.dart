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

class EditCarPage extends StatefulWidget {
  const EditCarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  final _form = GlobalKey<FormState>();
  bool? updated = false;

  TextEditingController? _videoId;
  TextEditingController? _model;
  TextEditingController? _year;
  TextEditingController? _price;
  TextEditingController? _description;

  Future<Car>? _carResponse;

  Future<List<FuelType>>? _futureFuelType;
  FuelType? _selectedFuelType;

  Future<List<Brand>>? _futureBrands;
  Brand? _selectedBrand;

  Future<List<Category>>? _futureCategories;
  Category? _selectedCategory;

  void submitForm(int id) {
    bool? validate = _form.currentState?.validate();
    if (!validate!) {
      return;
    }

    Car car = Car(
        model: _model!.value.text,
        year: int.parse(_year!.value.text),
        fuelType: _selectedFuelType!,
        price: double.parse(_price!.value.text),
        description: _description!.value.text,
        brand: _selectedBrand!,
        category: _selectedCategory!);

    CarService().update(id, car).then((value) {
      if (value) {
        final snackBar = SnackBar(
          content: const Text('Carro editado com sucesso!'),
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

  Future<void> _loadData() async {
    if (!updated!) {
      final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
      final int id = arguments['id'];

      _carResponse = CarService().getById(id);
      _futureFuelType = FuelTypeService().getAll();
      _futureBrands = BrandService().getAll();
      _futureCategories = CategoryService().getAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar carro'),
        ),
        body: FutureBuilder<List<dynamic>>(
            future: Future.wait([
              _loadData(),
              _carResponse!,
              _futureFuelType!,
              _futureBrands!,
              _futureCategories!,
            ]),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text('Erro ao buscar dados'));
              } else {
                Car car = snapshot.data![1] as Car;

                List<FuelType> fuelTypes = snapshot.data![2] as List<FuelType>;
                List<Brand> brands = snapshot.data![3] as List<Brand>;
                List<Category> categories = snapshot.data![4] as List<Category>;

                if (!updated!) {
                  _model = TextEditingController(text: car.model);
                  _year = TextEditingController(text: car.year.toString());
                  _price = TextEditingController(text: car.price.toString());
                  _description = TextEditingController(text: car.description);

                  _selectedFuelType = fuelTypes
                      .firstWhere((element) => element.id == car.fuelType.id);
                  _selectedBrand = brands
                      .firstWhere((element) => element.id == car.brand.id);
                  _selectedCategory = categories
                      .firstWhere((element) => element.id == car.category.id);
                  updated = true;
                }

                return SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 30),
                              child: Image.asset("images/car2.png", width: 200),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: _model,
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
                                controller: _year,
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
                                      if (yearValue < 1940 ||
                                          yearValue > currentYear) {
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
                            DropdownButtonFormField<Brand>(
                              value: _selectedBrand,
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
                                  _selectedBrand = value!;
                                });
                              },
                              items: brands
                                  .map<DropdownMenuItem<Brand>>((Brand value) {
                                return DropdownMenuItem<Brand>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                            DropdownButtonFormField<Category>(
                              value: _selectedCategory,
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
                                  _selectedCategory = value!;
                                });
                              },
                              items: categories.map<DropdownMenuItem<Category>>(
                                  (Category value) {
                                return DropdownMenuItem<Category>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                            DropdownButtonFormField<FuelType>(
                              value: _selectedFuelType,
                              hint: const Text(
                                  'Selecione um tipo de combustível'),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.category),
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
                                  _selectedFuelType = value!;
                                });
                              },
                              items: fuelTypes.map<DropdownMenuItem<FuelType>>(
                                  (FuelType value) {
                                return DropdownMenuItem<FuelType>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: _price,
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
                                controller: _description,
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
                                onPressed: () => submitForm(car.id),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.check),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Atualizar',
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
                );
              }
            }));
  }
}
