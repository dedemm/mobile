import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projetomobile/app/routes.dart';
import 'package:projetomobile/app/core/validators/usuario_validator.dart';

class CadastrarUsuariosScreen extends StatefulWidget {
  const CadastrarUsuariosScreen({super.key});

  @override
  State<CadastrarUsuariosScreen> createState() =>
      _CadastrarUsuariosScreenState();
}

class _CadastrarUsuariosScreenState extends State<CadastrarUsuariosScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  bool _nomeError = false;
  bool _emailError = false;
  bool _senhaError = false;
  bool _confirmarSenhaError = false;
  bool _obscureSenha = true;
  bool _obscureConfirmarSenha = true;

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
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _validarPCadastrar() {
    final result = UsuarioValidator.validateRegister(
      nome: _nomeController.text,
      email: _emailController.text,
      senha: _senhaController.text,
      confirmarSenha: _confirmarSenhaController.text,
    );

    setState(() {
      _nomeError = result.errors.contains('nome');
      _emailError = result.errors.contains('email');
      _senhaError = result.errors.contains('senha');
      _confirmarSenhaError = result.errors.contains('confirmarSenha');
    });

    if (!result.isValid) {
      _shakeController.forward(from: 0);
      _resetErrors();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifique os campos destacados.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      context.go(Routes.login);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _resetErrors() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _nomeError = false;
          _emailError = false;
          _senhaError = false;
          _confirmarSenhaError = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: child,
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Criar conta',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Preencha os dados abaixo para se cadastrar',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 40),

                  _buildTextField(
                    controller: _nomeController,
                    hintText: 'Nome completo',
                    icon: Icons.person_outline,
                    hasError: _nomeError,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _emailController,
                    hintText: 'E-mail',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    hasError: _emailError,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _senhaController,
                    hintText: 'Senha',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    isObscure: _obscureSenha, 
                    onToggleVisibility: () { 
                      setState(() {
                        _obscureSenha = !_obscureSenha;
                      });
                    },
                    hasError: _senhaError,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _confirmarSenhaController,
                    hintText: 'Confirmar senha',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    isObscure: _obscureConfirmarSenha, 
                    onToggleVisibility: () {           
                      setState(() {
                        _obscureConfirmarSenha = !_obscureConfirmarSenha;
                      });
                    },
                    hasError: _confirmarSenhaError,
                  ),
                  const SizedBox(height: 32),

                  FilledButton(
                    onPressed: _validarPCadastrar,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF006FFD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já possui uma conta? ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(Routes.login);
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Color(0xFF006FFD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool isObscure = false,
    VoidCallback? onToggleVisibility,
    TextInputType keyboardType = TextInputType.text,
    bool hasError = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isObscure : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hasError ? Colors.red[300] : Colors.grey[500],
        ),
        prefixIcon: Icon(icon, color: hasError ? Colors.red : Colors.grey[500]),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey[500],
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        filled: true,
        fillColor: hasError
            ? Colors.red.withValues(alpha: 0.05)
            : Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? Colors.red : Colors.grey[200]!,
            width: hasError ? 2 : 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? Colors.red : const Color(0xFF006FFD),
            width: 2,
          ),
        ),
      ),
    );
  }
}
