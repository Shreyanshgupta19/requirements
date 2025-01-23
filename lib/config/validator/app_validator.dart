
class AppValidator {
  static String? emailValidator(String email) {
    if (email.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    if (!emailValid) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String password) {
    if (password.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
  static String? phoneNumberValidator(String value) {
    if (value.trim() == null || value.isEmpty) {
      return 'This field cannot be empty';
    }if (!value.trim().contains(RegExp(r'^\d{10}$'))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  static String? nullCheckValidator(String value) {
    if (value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
}

