import 'package:consulta_cep/database/database_sqlite.dart';
import 'package:flutter/material.dart';

import '../controller/cep_controller.dart';
import '../model/cep.dart';

class ConsultaPage extends StatefulWidget {
  const ConsultaPage({Key? key}) : super(key: key);

  @override
  State<ConsultaPage> createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  final _cepTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dadosCep = '';
  Cep? cep;

  _databaseInsert(String cep, String logradouro, String complemento,
      String bairro, String localidade, String uf) async {
    final database = await DatabaseSqLite().openConnection();
    List<Map> result =
        await database.rawQuery("SELECT * from historico WHERE cep = '$cep'");
    if (result.isEmpty) {
      database.rawQuery('INSERT INTO historico VALUES(?,?,?,?,?,?)',
          [cep, logradouro, complemento, bairro, localidade, uf]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0277bd),
        title: const Text('Pesquisar'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Favor digitar um CEP';
                  } else if (value.length < 8) {
                    return 'Digite o CEP corretamente';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _cepTextController,
                maxLength: 8,
                decoration: const InputDecoration(
                  helperText: 'Digite somente números',
                  labelText: 'Digite aqui o CEP desejado',
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
              ),
            ),
            // Text(dadosCep),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  cep =
                      await CepController().buscarCEP(_cepTextController.text);
                  setState(
                    () {
                      _databaseInsert(
                          cep!.cep,
                          cep!.logradouro,
                          cep!.complemento,
                          cep!.bairro,
                          cep!.localidade,
                          cep!.uf);
                    },
                  );
                }
              },
              child: const Text('CLIQUE AQUI PARA CONSULTAR'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Visibility(
              visible: cep != null,
              replacement: const Text('Seu CEP aparecerá aqui!'),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CEP: ${_cepTextController.text}\n',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Logradouro: ${cep?.logradouro}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text('Bairro: ${cep?.bairro}',
                        style: const TextStyle(fontSize: 16)),
                    Text('Cidade: ${cep?.localidade}',
                        style: const TextStyle(fontSize: 16)),
                    Text('Estado: ${cep?.uf}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
