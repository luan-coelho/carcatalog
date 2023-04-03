import 'package:carshop/models/brand.dart';
import 'package:carshop/services/brand_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateCarPage extends StatefulWidget {
  const CreateCarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateCarPageState();
}

class _CreateCarPageState extends State<CreateCarPage> {
  late Future<List<Brand>> futureBrands;
  Brand? selectedBrand;

  @override
  void initState() {
    super.initState();
    futureBrands = BrandService().getAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    final model = TextEditingController();
    final year = TextEditingController();
    final fuelType = TextEditingController();
    final color = TextEditingController();
    final price = TextEditingController();
    final description = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
                key: form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: model,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Modelo',
                          prefixIcon: Icon(Icons.agriculture),
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
                            return Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Colors.black54),
                                    bottom: BorderSide(color: Colors.black54),
                                    left: BorderSide(color: Colors.black54),
                                    right: BorderSide(color: Colors.black54)),
                              ),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Brand>(
                                    value: selectedBrand,
                                    hint: const Text('Selecione uma marca...'),
                                    isExpanded: true,
                                    elevation: 24,
                                    onChanged: (Brand? value) {
                                      setState(() {
                                        selectedBrand = value!;
                                      });
                                    },
                                    items: brands.map<DropdownMenuItem<Brand>>(
                                        (Brand value) {
                                      return DropdownMenuItem<Brand>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(value.name),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ))));
  }
}
