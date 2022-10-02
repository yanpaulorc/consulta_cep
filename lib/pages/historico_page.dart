import 'package:flutter/material.dart';
import '../database/database_sqlite.dart';
import '../model/cep.dart';

List<Cep>? listaCep = [];

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({Key? key}) : super(key: key);

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  Cep? cep;

  @override
  initState() {
    super.initState();
    DatabaseSqLite().openConnection();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      listaCep = await consulta();
      setState(() {
        const CircularProgressIndicator();
      });
    });
  }

  Future<List<Cep>?> consulta() async {
    final database = await DatabaseSqLite().openConnection();
    List listMap = await database.rawQuery('select * from historico');
    List<Cep> listFinal = listMap.map((e) => Cep.fromMap(e)).toList();
    return listFinal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Histórico de consulta'),
        ),
        body: const CardHistorico());
  }
}

class CardHistorico extends StatefulWidget {
  const CardHistorico({super.key});

  @override
  State<CardHistorico> createState() => _CardHistoricoState();
}

class _CardHistoricoState extends State<CardHistorico> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: listaCep!.length,
        itemBuilder: (context, index) {
          final cep = listaCep![index];
          return Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.location_city,
                color: Colors.blue,
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
        },
      ),
    );
  }
}

// SizedBox(
//             height: 120,
//             width: 20,
//             child: Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.location_city, color: Colors.blue),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                               style: DefaultTextStyle.of(context).style,
//                               children: [
//                                 const TextSpan(
//                                     text: 'CEP - ',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                                 TextSpan(text: cep.cep),
//                               ],
//                             ),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                               style: DefaultTextStyle.of(context).style,
//                               children: [
//                                 const TextSpan(
//                                     text: 'Endereço: ',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                                 TextSpan(text: cep.logradouro),
//                               ],
//                             ),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                               style: DefaultTextStyle.of(context).style,
//                               children: [
//                                 const TextSpan(
//                                     text: 'Bairro: ',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                                 TextSpan(text: cep.bairro),
//                               ],
//                             ),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                               style: DefaultTextStyle.of(context).style,
//                               children: [
//                                 const TextSpan(
//                                     text: 'Cidade: ',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                                 TextSpan(
//                                     text:
//                                         '${cep.localidade} / ${cep.uf} aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );