import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:projetomobile/app/routes.dart';
import 'package:projetomobile/app/core/validators/denuncia_validator.dart';

class CriarDenunciasDetalheScreen extends StatefulWidget {
  final String titulo;
  final Color cor;

  const CriarDenunciasDetalheScreen({
    super.key,
    required this.titulo,
    required this.cor,
  });

  @override
  State<CriarDenunciasDetalheScreen> createState() => _CriarDenunciasDetalheScreenState();
}

class _CriarDenunciasDetalheScreenState extends State<CriarDenunciasDetalheScreen>
    with SingleTickerProviderStateMixin {
  // Controllers para os campos
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  // Estados de erro para validação
  bool _ruaError = false;
  bool _numeroError = false;
  bool _descricaoError = false;

  // Animation para shake
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -5.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -5.0, end: 0.0), weight: 1),
    ]).animate(_shakeController);
  }

  @override
  void dispose() {
    _ruaController.dispose();
    _numeroController.dispose();
    _descricaoController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  // Método para validar campos
  ValidationResult _validateFields() {
    final result = DenunciaValidator.validateFields(
      rua: _ruaController.text,
      numero: _numeroController.text,
      descricao: _descricaoController.text,
    );

    setState(() {
      _ruaError = result.errors.contains('rua');
      _numeroError = result.errors.contains('numero');
      _descricaoError = result.errors.contains('descricao');
    });

    if (!result.isValid) {
      _shakeController.forward(from: 0);
    }

    return result;
  }

  // Método para resetar erros após um tempo
  void _resetErrors() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _ruaError = false;
          _numeroError = false;
          _descricaoError = false;
        });
      }
    });
  }

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
    final Color textColor = _textColors[widget.titulo] ?? Colors.black;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: Container(
              // Degradê da cor principal até quase branco
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.cor, Colors.white],
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Icon(Icons.arrow_back, color: textColor),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              widget.titulo,
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
                                    controller: _ruaController,
                                    hintText: 'Rua',
                                    hasError: _ruaError,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: _buildTextFieldWithShadow(
                                    controller: _numeroController,
                                    hintText: 'Nº',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    hasError: _numeroError,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Botão "Usar minha localização" com sombra e InkWell
                            _buildButtonWithShadow(
                              context: context,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Em desenvolvimento'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              text: 'Usar minha localização',
                              backgroundColor: widget.cor.withValues(alpha: 0.7),
                              textColor: textColor,
                            ),
                            const SizedBox(height: 16),

                            // Campo descrição com sombra
                            _buildTextFieldWithShadow(
                              controller: _descricaoController,
                              hintText: 'Descreva o problema...',
                              maxLines: 5,
                              hasError: _descricaoError,
                            ),
                            const SizedBox(height: 20),

                            // Botão "Enviar denúncia" com sombra e InkWell
                            _buildButtonWithShadow(
                              context: context,
                              onTap: () {
                                final result = _validateFields();
                                if (result.isValid) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Campos validados com sucesso'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  _resetErrors();
                                }
                              },
                              text: 'ENVIAR DENÚNCIA',
                              backgroundColor: widget.cor,
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
          );
        },
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
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    bool hasError = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
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
            borderSide: hasError
                ? const BorderSide(color: Colors.red, width: 2)
                : BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: hasError
                ? const BorderSide(color: Colors.red, width: 2)
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: hasError
                ? const BorderSide(color: Colors.red, width: 2)
                : BorderSide.none,
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
        splashColor: backgroundColor.withValues(alpha: 0.3),
        highlightColor: backgroundColor.withValues(alpha: 0.1),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
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