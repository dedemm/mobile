class UsuarioValidator {
  static ValidationResult validateLoginFields({
    required String email,
    required String senha,
  }) {
    final errors = <String>[];

    if (email.trim().isEmpty || !email.contains('@')) {
      errors.add('email');
    }
    if (senha.trim().isEmpty || senha.length < 3) {
      errors.add('senha');
    }

    return ValidationResult(isValid: errors.isEmpty, errors: errors);
  }

  static ValidationResult validateRegister({
    required String nome,
    required String email,
    required String senha,
    required String confirmarSenha,
  }) {
    final errors = <String>[];

    if (nome.trim().isEmpty) {
      errors.add('nome');
    }
    if (email.trim().isEmpty || !email.contains('@')) {
      errors.add('email');
    }
    if (senha.trim().isEmpty || senha.length < 3) {
      errors.add('senha');
    }
    if (confirmarSenha != senha) {
      errors.add('confirmarSenha');
    }

    return ValidationResult(isValid: errors.isEmpty, errors: errors);
  }
}

class ValidationResult {
  final bool isValid;
  final List<String> errors;

  ValidationResult({required this.isValid, required this.errors});
}
