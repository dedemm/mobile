import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:projetomobile/app/routes.dart';

class CriarDenunciasDetalheScreen extends StatelessWidget {
  final String titulo;
  final Color cor;

  const CriarDenunciasDetalheScreen({
    super.key,
    required this.titulo,
    required this.cor,
  });

  // Mapa com cores de texto para cada categoria (inclui os botões)
  static const Map<String, Color> _textColors = {
    'Meio Ambiente': Colors.black,
    'Trânsito e Sinalização': Colors.black,
    'Energia': Colors.black,
    'Estradas e Ruas': Colors.white,
    'Saneamento': Colors.white,
  };

  @override
  Widget build(BuildContext context) {
    final Color textColor = _textColors[titulo] ?? Colors.black;

    return Scaffold(
      body: Container(
        // Degradê da cor principal até quase branco
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Cabeçalho
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(Icons.arrow_back, color: textColor),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        titulo,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              // Conteúdo rolável
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Placeholder da imagem (sem sombra, conforme solicitado)
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Icon(Icons.image, size: 40, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Campos Rua e Nº com sombra
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildTextFieldWithShadow(
                              hintText: 'Rua',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: _buildTextFieldWithShadow(
                              hintText: 'Nº',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Botão "Usar minha localização" com sombra e InkWell
                      _buildButtonWithShadow(
                        context: context,
                        onTap: () {
                          // TODO: implementar localização
                        },
                        text: 'Usar minha localização',
                        backgroundColor: cor.withOpacity(0.7),
                        textColor: textColor,
                      ),
                      const SizedBox(height: 16),

                      // Campo descrição com sombra
                      _buildTextFieldWithShadow(
                        hintText: 'Descreva o problema...',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),

                      // Botão "Enviar denúncia" com sombra e InkWell
                      _buildButtonWithShadow(
                        context: context,
                        onTap: () {
                          // TODO: implementar envio
                        },
                        text: 'ENVIAR DENÚNCIA',
                        backgroundColor: cor,
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
              ),
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

  // Widget auxiliar para TextField com sombra
  Widget _buildTextFieldWithShadow({
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para botões com sombra e feedback visual
  Widget _buildButtonWithShadow({
    required BuildContext context,
    required VoidCallback onTap,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 14,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: backgroundColor.withOpacity(0.3),
        highlightColor: backgroundColor.withOpacity(0.1),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}