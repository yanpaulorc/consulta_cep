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
        colorScheme: const ColorScheme.light()
            .copyWith(primary: const Color(0XFF002f6c)),
      ),
      home: const HomePage(),
    );
  }
}
