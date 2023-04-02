import 'package:carshop/pages/car_page.dart';
import 'package:carshop/pages/index_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String cars = '/cars';

  static final Map<String, WidgetBuilder> routes = {
    home: (BuildContext context) => const IndexPage(),
    cars: (BuildContext context) => const CarPage(),
  };
}
