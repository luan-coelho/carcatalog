import 'package:carshop/pages/car/index_page.dart';
import 'package:carshop/pages/car/create_page.dart';
import 'package:carshop/pages/car/show_page.dart';
import 'package:carshop/pages/index_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  /*Cars*/
  static const String cars = '/cars';
  static const String showCar = '/cars/show';
  static const String createCar = '/cars/create';

  static final Map<String, WidgetBuilder> routes = {
    home: (BuildContext context) => const IndexPage(),
    cars: (BuildContext context) => const IndexCarPage(),
    showCar: (BuildContext context) => const ShowCarPage(),
    createCar: (BuildContext context) => const CreateCarPage(),
  };
}