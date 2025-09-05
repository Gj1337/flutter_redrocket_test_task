import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _tokenKey = 'auth_token';

@Singleton()
class AuthTokenHandler {
  final FlutterSecureStorage _flutterSecureStorage;

  AuthTokenHandler(this._flutterSecureStorage);

  final _tokenController = StreamController<String?>.broadcast();

  Stream<String?> get tokenStream => _tokenController.stream;

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
