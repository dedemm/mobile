import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetomobile/app/routes.dart';

class CriarDenunciasScreen extends StatelessWidget {
  const CriarDenunciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = [
      {
        'title': 'Meio Ambiente',
        'color': Color(0xFFC9FDC5),
        'textColor': Colors.black,
        'route': Routes.criarDenunciaMA,
      },
      {
        'title': 'Trânsito e Sinalização',
        'color': Color(0xFFFFC65C),
        'textColor': Colors.black,
        'route': Routes.criarDenunciaTS,
      },
      {
        'title': 'Energia',
        'color': Color(0xFFFFF600),
        'textColor': Colors.black,
        'route': Routes.criarDenunciaE,
      },
      {
        'title': 'Estradas e Ruas',
        'color': Color(0xFF484C49),
        'textColor': Colors.white,
        'route': Routes.criarDenunciaER,
      },
      {
        'title': 'Saneamento',
        'color': Color(0xFF113FA3),
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
                  style: GoogleFonts.instrumentSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,  
                  ),
                ),
              ),
              SizedBox(height: 30),
              ...categorias.map((categoria) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      context.push(categoria['route'] as String);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                        color: categoria['color'] as Color,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        categoria['title'] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: categoria['textColor'] as Color,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,  
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(Routes.denuncias);
              break;
            case 1:
              // Já estamos na tela de criar denúncia, então não fazemos nada
              break;
            case 2:
              context.go(Routes.perfil);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Denúncias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Criar Denúncia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Color(0xFF006FFD),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}