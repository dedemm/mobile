import 'package:flutter/material.dart';
import 'package:projetomobile/app/features/denuncias/criar_denuncias_viewmodel.dart';
import 'package:projetomobile/app/routes.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CriarDenunciasViewmodel>(
          create: (context) => CriarDenunciasViewmodel(),
        ),
      ],
      child: Builder(
        builder: (context){
          return MaterialApp.router(
            title: 'Criar Denúncia',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),  
            routerConfig: routes,
          );
        }
      )
    );
  }
}