import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetomobile/app/routes.dart';

class MockDB {
  static List<Map<String, dynamic>> denuncias = [
    //Exemplo mockado
    {
      'categoria': 'Estradas e Ruas',
      'descricao': 'Buraco na rua',
      'status': 'Concluído',
      'corFundo': const Color(0xFF484C49),
      'corTexto': Colors.white,
    },
    {
      'categoria': 'Meio Ambiente',
      'descricao': 'Árvore caída',
      'status': 'Concluído',
      'corFundo': const Color(0xFFC9FDC5),
      'corTexto': Colors.black,
    },
    {
      'categoria': 'Trânsito e Sinalização',
      'descricao': 'Placa incongruente',
      'status': 'Não aprovado',
      'corFundo': const Color(0xFFFFC65C),
      'corTexto': Colors.black,
    },
  ];
}

class DenunciasScreen extends StatelessWidget {
  const DenunciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Instancia o mock de dados para simular as denúncias realizadas
    final denunciasRealizadas = MockDB.denuncias;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Cabeçalho
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    'DENÚNCIAS REALIZADAS',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: denunciasRealizadas.length,
                itemBuilder: (context, index) {
                  final denuncia = denunciasRealizadas[index];
                  return _buildDenunciaCard(denuncia);
                },
              ),
            ),
          ],
        ),
      ),

      // 4. BARRA INFERIOR MANTIDA
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Já estamos aqui
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
        selectedItemColor: const Color(0xFF006FFD),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // WIDGET AUXILIAR: Constrói cada "cartão" da lista
  Widget _buildDenunciaCard(Map<String, dynamic> data) {
    // Define a cor da bolinha de status baseada no texto
    Color statusColor;
    if (data['status'] == 'Concluído') {
      statusColor = Colors.greenAccent;
    } else if (data['status'] == 'Não aprovado') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.yellow;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: data['corFundo'],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Lado Esquerdo: Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['categoria'],
                  style: GoogleFonts.inter(
                    color: data['corTexto'],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data['descricao'],
                  style: GoogleFonts.inter(
                    color: data['corTexto'].withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Lado Direito: Pílula de Status Branca
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: statusColor, width: 2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  data['status'],
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
