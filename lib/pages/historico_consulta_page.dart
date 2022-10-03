import 'package:consulta_cep/database/database_sqlite.dart';
import 'package:flutter/material.dart';

import '../model/cep.dart';

class HistoricoConsultaPage extends StatefulWidget {
  const HistoricoConsultaPage({Key? key}) : super(key: key);

  @override
  State<HistoricoConsultaPage> createState() => _HistoricoConsultaPageState();
}

class _HistoricoConsultaPageState extends State<HistoricoConsultaPage> {
  Future<List<Cep>?>? listaCep;
  final _buscaController = TextEditingController();
  Cep? cep;

  @override
  void initState() {
    super.initState();
    // listaCep = consulta();
  }

  Future<List<Cep>?> consulta(String texto) async {
    final database = await DatabaseSqLite().openConnection();
    List listMap = await database
        .rawQuery("SELECT * FROM historico WHERE logradouro LIKE '%$texto%'");
    List<Cep> listFinal = listMap.map((e) => Cep.fromMap(e)).toList();
    print(listFinal[0]);
    return listFinal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar endereço'),
        actions: const [],
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) {},
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                // final enderecos = listaCep?[index];
                return const ListTile(
                  title: Text('enderecos'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
