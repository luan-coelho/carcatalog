import 'package:car_catalog_client/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo de Carros',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      initialRoute: '/auth/login',
      routes: AppRoutes.routes,
    );
  }
}
