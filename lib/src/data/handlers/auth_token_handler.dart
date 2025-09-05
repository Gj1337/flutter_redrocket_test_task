import 'dart:async';
import 'dart:convert';

import 'package:flutter_redrocket_test_task/src/domain/entity/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _tokenKey = 'auth_token';
const _userKey = 'user';

@Singleton()
class AuthHandler {
  final FlutterSecureStorage _flutterSecureStorage;

  AuthHandler(this._flutterSecureStorage);

  final _tokenController = StreamController<String?>.broadcast();

  Stream<String?> get tokenStream => _tokenController.stream;

  Future<User?> getUser() async {
    final rawJson = await _flutterSecureStorage.read(key: _userKey);

    if (rawJson == null || rawJson.isEmpty) {
      return null;
    }

    final json = jsonDecode(rawJson) as Map<String, dynamic>;

    return User.fromJson(json);
  }

  Future<void> updateUser(User user) async {
    final json = user.toJson();
    final rawJson = jsonEncode(json);

    await _flutterSecureStorage.write(key: _userKey, value: rawJson);
  }

  Future<void> removeToken() async {
    await _flutterSecureStorage.delete(key: _tokenKey);
    _tokenController.add(null);
  }

  Future<void> updateToken(String token) async {
    await _flutterSecureStorage.write(key: _tokenKey, value: token);
    _tokenController.add(token);
  }

  Future<String?> getToken() async {
    return _flutterSecureStorage.read(key: _tokenKey);
  }

  @disposeMethod
  void dispose() {
    _tokenController.close();
  }
}
