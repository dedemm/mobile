import 'package:flutter/material.dart';
import 'package:projetomobile/app/core/validators/usuario_validator.dart';

class UsuarioViewModel extends ChangeNotifier {
  String nome = '';
  String email = '';

  bool isLoading = false;

  List<String> errors = [];

  bool login(String emailInput, String senhaInput) {
    final result = UsuarioValidator.validateLoginFields(
      email: emailInput,
      senha: senhaInput,
    );

    errors = result.errors;
    notifyListeners();

    if (!result.isValid) return false;

    email = emailInput;

    return true;
  }

  bool cadastrar({
    required String nomeInput,
    required String emailInput,
    required String senhaInput,
    required String confirmarSenhaInput,
  }) {
    final result = UsuarioValidator.validateRegister(
      nome: nomeInput,
      email: emailInput,
      senha: senhaInput,
      confirmarSenha: confirmarSenhaInput,
    );

    errors = result.errors;
    notifyListeners();

    if (!result.isValid) return false;

    nome = nomeInput;
    email = emailInput;

    return true;
  }

  void logout() {
    nome = '';
    email = '';
    notifyListeners();
  }

  bool hasError(String field) {
    return errors.contains(field);
  }
}