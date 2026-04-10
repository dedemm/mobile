import 'package:go_router/go_router.dart';
import 'package:projetomobile/app/features/denuncias/criar_denuncias_screen.dart';
import 'package:provider/provider.dart';

class Routes {
  static const criarDenuncia = '/criar-denuncia';
}

final routes = GoRouter(
  initialLocation: Routes.criarDenuncia,
  routes: [
    GoRoute(
      path: Routes.criarDenuncia,
      name: Routes.criarDenuncia, 
      builder: (context, state) => CriarDenunciasScreen(
        criarDenunciasViewmodel: context.read(),
      ),
    )
  ] 
  );