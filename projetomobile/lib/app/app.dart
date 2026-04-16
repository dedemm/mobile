import 'package:flutter/material.dart';
import 'package:projetomobile/app/routes.dart';
import 'package:provider/provider.dart';
import 'features/usuarios/viewmodels/usuario_viewmodel.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsuarioViewModel(),
      child: MaterialApp.router(
        title: 'Criar Denúncia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: routes,
      ),
    );
  }
}
