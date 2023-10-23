part of 'utilities.dart';

class Validation {
  static email(String? email) {
    if (email!.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!EmailValidator.validate(email)) {
      return 'Pastikan format email anda sudah benar';
    } else {
      return null;
    }
  }

  static password({
    required String password,
  }) {
    if (password.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (password.length < 8) {
      return 'Password minimal terdiri 8 karakter';
    } else {
      return null;
    }
  }

  static field({String? value, required String namaField}) {
    if (value!.isEmpty) {
      return '$namaField tidak boleh kosong';
    } else {
      return null;
    }
  }
}
