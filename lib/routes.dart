import 'package:carshop/pages/car/create_page.dart';
import 'package:carshop/pages/car/edit_page.dart';
import 'package:carshop/pages/car/index_page.dart';
import 'package:carshop/pages/car/show_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String cars = '/cars';
  static const String showCar = '/cars/show';
  static const String createCar = '/cars/create';
  static const String editCar = '/cars/edit';

  static final Map<String, WidgetBuilder> routes = {
    cars: (BuildContext context) => const IndexCarPage(),
    showCar: (BuildContext context) => const ShowCarPage(),
    createCar: (BuildContext context) => const CreateCarPage(),
    editCar: (BuildContext context) => const EditCarPage(),
  };
}
