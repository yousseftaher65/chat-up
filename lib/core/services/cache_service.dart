import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
  Future<void> remove(String key);
}

@Singleton(as: CacheService)
class CacheServiceImpl implements CacheService {
  CacheServiceImpl() {
    SharedPreferences.getInstance().then(
      (value) => _sharedPreCompleter.complete(value),
    );
  }

  final _sharedPreCompleter = Completer<SharedPreferences>();

  @override
  Future<String?> getString(String key) async {
    final prefs = await _sharedPreCompleter.future;
    return Future.value(prefs.getString(key));
  }

  @override
  Future<void> setString(String key, String value) async {
    final prefs = await _sharedPreCompleter.future;
    prefs.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    final prefs = await _sharedPreCompleter.future;
    await prefs.remove(key);
  }
}
