import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projetomobile/app/routes.dart';

class DenunciasScreen extends StatelessWidget {
  const DenunciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Denúncias')),
      body: Center(child: Text('Denúncias')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              context.go(Routes.criarDenuncia);
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: Color(0xFF006FFD),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
