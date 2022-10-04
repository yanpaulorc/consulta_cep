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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar endereço'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                helperText: 'Digite um trecho do endereço desejado',
                labelText: 'Digite aqui...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              onChanged: (value) async {
                if (value == '') {
                  setState(() {
                    listaCep?.clear();
                  });
                } else {
                  listaCep = await consulta(_buscaController.text);
                  setState(() {});
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_buscaController.text == '') {
                setState(() {
                  listaCep?.clear();
                });
              } else {
                listaCep = await consulta(_buscaController.text);
                setState(() {});
              }
            },
            child: const Text('Clique aqui para pesquisar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listaCep?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final enderecos = listaCep?[index];
                return Card(
                  child: ListTile(
                    title: Text('${enderecos?.cep}'),
                    subtitle: Text('${enderecos?.logradouro}'),
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
