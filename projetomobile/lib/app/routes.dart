import 'package:go_router/go_router.dart';
import 'package:projetomobile/app/features/denuncias/criar_denuncias_screen.dart';
import 'package:flutter/material.dart';
import 'package:projetomobile/app/features/denuncias/criar_denuncias_detalhe_screen.dart';

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
    GoRoute(
      path: Routes.criarDenunciaMA,
      name: Routes.criarDenunciaMA,
      builder: (context, state) => CriarDenunciasDetalheScreen(
        titulo: 'Meio Ambiente',
        cor: Color(0xFFC9FDC5),
      ),
    ),
    GoRoute(
      path: Routes.criarDenunciaTS,
      name: Routes.criarDenunciaTS,
      builder: (context, state) => CriarDenunciasDetalheScreen(
        titulo: 'Trânsito e Sinalização',
        cor: Color(0xFFFFC65C),
      ),
    ),
    GoRoute(
      path: Routes.criarDenunciaE,
      name: Routes.criarDenunciaE,
      builder: (context, state) => CriarDenunciasDetalheScreen(
        titulo: 'Energia',
        cor: Color(0xFFFFF600),
      ),
    ),
    GoRoute(
      path: Routes.criarDenunciaER,
      name: Routes.criarDenunciaER,
      builder: (context, state) => CriarDenunciasDetalheScreen(
        titulo: 'Estradas e Ruas',
        cor: Color(0xFF484C49),
      ),
    ),
    GoRoute(
      path: Routes.criarDenunciaS,
      name: Routes.criarDenunciaS,
      builder: (context, state) => CriarDenunciasDetalheScreen(
        titulo: 'Saneamento',
        cor: Color(0xFF113FA3),
      ),
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(body: Center(child: Text('Página não encontrada')));
  },
);
