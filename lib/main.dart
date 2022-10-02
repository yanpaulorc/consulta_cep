import 'package:consulta_cep/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta CEP',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF1976d2, {
          50: Color(0xFFe3f2fd),
          100: Color(0xFFbbdefb),
          200: Color(0xFF90caf9),
          300: Color(0xFF64b5f6),
          400: Color(0xFF42a5f5),
          500: Color(0xFF2196f3),
          600: Color(0xFF1e88e5),
          700: Color(0xFF1976d2),
          800: Color(0xFF1565c0),
          900: Color(0xFF0d47a1),
        }),
      ),
      home: const HomePage(),
    );
  }
}
