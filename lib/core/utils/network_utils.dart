import 'dart:io';

Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty;
  } catch (_) {
    return false;
  }
}
