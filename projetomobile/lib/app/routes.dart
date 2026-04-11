import 'package:go_router/go_router.dart';
import 'package:projetomobile/app/features/denuncias/criar_denuncias_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const criarDenuncia = '/criar-denuncia';
  static const criarDenunciaMA = '/criar-denuncia/meio-ambiente';
  static const criarDenunciaTS = '/criar-denuncia/transito-sinalizacao';
  static const criarDenunciaE = '/criar-denuncia/energia';
  static const criarDenunciaER = '/criar-denuncia/estradas-ruas';
  static const criarDenunciaS = '/criar-denuncia/saneamento';
  static const denuncias = '/denuncias';
  static const perfil = '/perfil';
}

final routes = GoRouter(
  initialLocation: Routes.criarDenuncia,
  routes: [
    GoRoute(
      path: Routes.criarDenuncia,
      name: Routes.criarDenuncia,
      builder: (context, state) => CriarDenunciasScreen(),
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(body: Center(child: Text('Página não encontrada')));
  },
);
