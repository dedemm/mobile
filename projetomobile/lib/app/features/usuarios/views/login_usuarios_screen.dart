import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:projetomobile/app/routes.dart';
import 'package:projetomobile/app/features/usuarios/viewmodels/usuario_viewmodel.dart';

class LoginUsuariosScreen extends StatefulWidget {
  const LoginUsuariosScreen({super.key});

  @override
  State<LoginUsuariosScreen> createState() => _LoginUsuariosScreenState();
}

class _LoginUsuariosScreenState extends State<LoginUsuariosScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _obscureSenha = true;

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
    _emailController.dispose();
    _senhaController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _login() {
    final vm = context.read<UsuarioViewModel>();

    final success = vm.login(
      _emailController.text,
      _senhaController.text,
    );

    if (!success) {
      _shakeController.forward(from: 0);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifique os campos destacados.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      context.go(Routes.denuncias);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UsuarioViewModel>();

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
                  const SizedBox(height: 80),
                  const Text(
                    'Bem-vindo',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Insira seus dados para acessar sua conta',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 40),

                  _buildTextField(
                    controller: _emailController,
                    hintText: 'E-mail',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    hasError: vm.hasError('email'),
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _senhaController,
                    hintText: 'Senha',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    hasError: vm.hasError('senha'),
                  ),
                  const SizedBox(height: 32),

                  FilledButton(
                    onPressed: _login,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF006FFD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Entrar',
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
                        'Não possui uma conta? ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(Routes.cadastro);
                        },
                        child: const Text(
                          'Criar',
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
    TextInputType keyboardType = TextInputType.text,
    bool hasError = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscureSenha : false,
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
                  _obscureSenha
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _obscureSenha = !_obscureSenha;
                  });
                },
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