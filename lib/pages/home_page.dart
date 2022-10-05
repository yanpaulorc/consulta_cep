// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:consulta_cep/pages/historico_consulta_page.dart';
import 'package:consulta_cep/pages/historico_page.dart';
import 'package:flutter/material.dart';

import 'package:consulta_cep/pages/consulta_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFe1f5fe),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(0, 1))
                    ],
                    // color: const Color(0XFFCDCDCD),
                    color: const Color(0XFF002f6c),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/home.png'),
                        fit: BoxFit.fitHeight)),
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: MyWidget(
                  texto: 'Consulta CEP',
                  icon: Icons.search,
                  ontTap: () {
                    goToPage(context, const ConsultaPage());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: MyWidget(
                  texto: 'Consultar histórico',
                  icon: Icons.manage_search_outlined,
                  ontTap: () {
                    goToPage(context, const HistoricoConsultaPage());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: MyWidget(
                  texto: 'Histórico de consulta',
                  icon: Icons.description_outlined,
                  ontTap: () {
                    goToPage(context, const HistoricoPage());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String texto;
  final VoidCallback ontTap;
  final IconData icon;

  const MyWidget({
    Key? key,
    required this.texto,
    required this.ontTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightCard = 80;
    final mediaQueryWidth = MediaQuery.of(context).size.width * 0.85;
    final borderRadius = BorderRadius.circular(8);

    return Material(
      elevation: 10,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {
          ontTap();
        },
        borderRadius: borderRadius,
        child: Container(
          height: heightCard,
          width: mediaQueryWidth,
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Row(
            children: [
              Container(
                height: heightCard,
                width: heightCard,
                decoration: const BoxDecoration(
                  color: Color(0XFF002f6c),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    texto,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
