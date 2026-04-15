class DenunciaValidator {
  static ValidationResult validateFields({
    required String estado,
    required String cidade,
    required String rua,
    required String numero,
    required String cep,
    required String descricao,
  }) {
    final errors = <String>[];

    if (estado.trim().isEmpty) {
      errors.add('estado');
    }
    if (cidade.trim().isEmpty) {
      errors.add('cidade');
    }
    if (rua.trim().isEmpty) {
      errors.add('rua');
    }
    if (numero.trim().isEmpty) {
      errors.add('numero');
    }
    if (cep.trim().isEmpty) {
      errors.add('cep');
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