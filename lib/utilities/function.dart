part of 'utilities.dart';

class Functions {
  final box = GetStorage();

  void saveToken({
    required String token,
  }) {
    box.write('token', token);
  }

  String? getToken() {
    return box.read<String?>('token');
  }

  Future getImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png'],
    );
    if (result == null) return;

    return result.files.first.path;
  }
}
