import 'package:consulta_cep/database/database_sqlite.dart';
import 'package:flutter/material.dart';

import '../model/cep.dart';

class HistoricoConsultaPage extends StatefulWidget {
  const HistoricoConsultaPage({Key? key}) : super(key: key);

  @override
  State<HistoricoConsultaPage> createState() => _HistoricoConsultaPageState();
}

class _HistoricoConsultaPageState extends State<HistoricoConsultaPage> {
  List<Cep>? listaCep = [];
  final _buscaController = TextEditingController();
  Cep? cep;

  Future<List<Cep>?> consulta(String texto) async {
    final database = await DatabaseSqLite().openConnection();
    List listMap = await database
        .rawQuery("SELECT * FROM historico WHERE logradouro LIKE '%$texto%'");
    List<Cep> listFinal = listMap.map((e) => Cep.fromMap(e)).toList();
    return listFinal;
  }

  @override
  void dispose() {
    super.dispose();
    _buscaController.dispose();
  }

  void _clearText() {
    _buscaController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0277bd),
        title: const Text('Pesquisar endereço'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _buscaController,
              decoration: InputDecoration(
                suffixIcon: _buscaController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: (() {
                          _clearText();
                          listaCep?.clear();
                        }),
                        icon: const Icon(Icons.close),
                      ),
                helperText: 'Digite um trecho do endereço desejado',
                labelText: 'Digite aqui...',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              onChanged: (value) async {
                if (value.isEmpty) {
                  listaCep?.clear();
                  setState(() {});
                } else {
                  listaCep = await consulta(_buscaController.text);
                  setState(() {});
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listaCep?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final enderecos = listaCep?[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      '${enderecos?.cep}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Text(
                      '${enderecos?.logradouro}\n${enderecos?.bairro}\n${enderecos?.localidade} / ${enderecos!.uf}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
