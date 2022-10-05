import 'dart:async';

import 'package:flutter/material.dart';
import '../database/database_sqlite.dart';
import '../model/cep.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({Key? key}) : super(key: key);

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  Future<List<Cep>?>? listaCep;
  Cep? cep;

  @override
  void initState() {
    super.initState();
    listaCep = consulta();
  }

  Future<List<Cep>?> consulta() async {
    final database = await DatabaseSqLite().openConnection();
    List listMap = await database.rawQuery('SELECT * FROM historico');
    List<Cep> listFinal = listMap.map((e) => Cep.fromMap(e)).toList();
    return listFinal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0277bd),
        title: const Text('Histórico de consulta'),
        actions: const [],
      ),
      body: FutureBuilder<List<Cep>?>(
        future: listaCep,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final cep = snapshot.data![index];
                if (snapshot.data!.isNotEmpty) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      leading: const Icon(
                        Icons.location_city,
                        color: Colors.black,
                      ),
                      title: Text(
                        cep.cep,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${cep.logradouro}\nBairro: ${cep.bairro}\n${cep.localidade} / ${cep.uf}',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                        'Não há nenhuma consulta registrada no histórico!'),
                  );
                }
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
