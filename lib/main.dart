import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_redrocket_test_task/src/app.dart';
import 'package:flutter_redrocket_test_task/src/di/di_setup.dart';
import 'package:get_it/get_it.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final getIt = await initializeDependencyContainer(GetIt.instance);
  FlutterNativeSplash.remove();

  runApp(App(getIt: getIt));
}
