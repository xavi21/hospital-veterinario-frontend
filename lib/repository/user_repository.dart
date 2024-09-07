import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:paraiso_canino/resources/constants.dart';

import 'repository_constants.dart';

class UserRepository {
  final FlutterSecureStorage storage;

  UserRepository() : storage = const FlutterSecureStorage();

  UserRepository.withStorage(
    this.storage,
  );

  Future<String> getBearerToken() async {
    return (await storage.read(key: token)) ?? emptyString;
  }

  Future<void> saveBearerToken({required String newToken}) async {
    await storage.write(
      key: token,
      value: newToken,
    );
  }

  Future<String> getReminderEmail() async {
    try {
      final data = (await storage.read(key: userEmail)) ?? emptyString;
      return data;
    } catch (e) {
      return '';
    }
  }

  Future<void> rememberEmail({required String email}) async {
    await storage.write(
      key: userEmail,
      value: email,
    );
  }

  Future<void> saveRemeberMailCheck({required bool isCkecked}) async {
    await storage.write(
      key: rememberMail,
      value: '$isCkecked',
    );
  }

  Future<bool> rememberMailChecked() async {
    String checkStatus = await storage.read(key: rememberMail) ?? 'false';
    return checkStatus == 'true';
  }

  Future<bool> isSession() async {
    return (await getBearerToken()).isEmpty;
  }

  Future<void> clearAllData() async {
    await storage.deleteAll();
  }
}
