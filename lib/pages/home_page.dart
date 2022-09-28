import 'package:consulta_cep/controller/cep_controller.dart';
import 'package:consulta_cep/model/cep.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cepTextController = TextEditingController();
  String dadosCep = '';
  Cep? cep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta CEP'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(controller: _cepTextController, maxLength: 8),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(dadosCep),
          ),
          ElevatedButton(
            onPressed: () async {
              cep = await CepController().buscarCEP(_cepTextController.text);
              setState(
                () {
                  // dadosCep = CepController;
                },
              );
            },
            child: const Text('CONSULTAR CEP'),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          Visibility(
            visible: cep != null,
            replacement: const Text("Pesquise o CEP!"),
            child: Column(
              children: [
                Text("Cep: ${cep?.cep}"),
                Text("Logradouro: ${cep?.logradouro}"),
                Text("Bairro: ${cep?.bairro}"),
                Text("Localidade: ${cep?.localidade}"),
                Text("UF: ${cep?.uf}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
