class DenunciaValidator {
  static ValidationResult validateFields({
    required String rua,
    required String numero,
    required String descricao,
  }) {
    final errors = <String>[];

    if (rua.trim().isEmpty) {
      errors.add('rua');
    }
    if (numero.trim().isEmpty) {
      errors.add('numero');
    }
    if (descricao.trim().isEmpty) {
      errors.add('descricao');
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

class ValidationResult {
  final bool isValid;
  final List<String> errors;

  ValidationResult({
    required this.isValid,
    required this.errors,
  });
}