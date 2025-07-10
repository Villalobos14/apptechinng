// lib/core/utils/validators.dart

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'El email es requerido';
    }
    
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Ingresa un email válido';
    }
    
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'El nombre de usuario es requerido';
    }
    
    if (username.length < 3 || username.length > 50) {
      return 'Debe tener entre 3 y 50 caracteres';
    }
    
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!usernameRegex.hasMatch(username)) {
      return 'Solo letras, números, _ y - permitidos';
    }
    
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'La contraseña es requerida';
    }
    
    if (password.length < 8) {
      return 'Mínimo 8 caracteres';
    }
    
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Debe contener al menos una mayúscula';
    }
    
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Debe contener al menos una minúscula';
    }
    
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Debe contener al menos un número';
    }
    
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Debe contener al menos un carácter especial';
    }
    
    return null;
  }

  static String? validateLoginField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    
    // Puede ser email o username
    if (value.contains('@')) {
      return validateEmail(value);
    } else {
      return validateUsername(value);
    }
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirma tu contraseña';
    }
    
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    return null;
  }
}