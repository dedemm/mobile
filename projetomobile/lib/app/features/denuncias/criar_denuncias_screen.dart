import 'package:flutter/material.dart';
import 'package:projetomobile/app/widgets/criar_denuncias_button.dart';
import 'package:projetomobile/app/routes.dart';
import 'package:go_router/go_router.dart';

class CriarDenunciasScreen extends StatelessWidget {
  const CriarDenunciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = [
      {
        'title': 'Meio Ambiente',
        'color': Colors.green,
        'textColor': Colors.black,
        'route': Routes.criarDenunciaMA,
      },
      {
        'title': 'Trânsito e Sinalização',
        'color': Colors.orange,
        'textColor': Colors.black,
        'route': Routes.criarDenunciaTS,
      },
      {
        'title': 'Energia',
        'color': Colors.yellow,
        'textColor': Colors.black,
        'route': Routes.criarDenunciaE,
      },
      {
        'title': 'Estradas e Ruas',
        'color': Colors.black,
        'textColor': Colors.white,
        'route': Routes.criarDenunciaER,
      },
      {
        'title': 'Saneamento',
        'color': Colors.blue,
        'textColor': Colors.white,
        'route': Routes.criarDenunciaS,
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Qual o motivo da sua \ndenúncia?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              ...categorias.map((categoria) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CriarDenunciasButton(
                    title: categoria['title'] as String,
                    backgroundColor: categoria['color'] as Color,
                    textColor: categoria['textColor'] as Color,
                    onTap: () {
                      context.push(categoria['route'] as String);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
