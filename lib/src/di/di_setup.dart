import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_redrocket_test_task/src/di/di_setup.config.dart';

const _envFiles = {'dev': 'env/.env.dev', 'test': 'env/.env.test'};

@InjectableInit(asExtension: false)
Future<GetIt> initializeDependencyContainer(GetIt getIt) async {
  const env = String.fromEnvironment('ENV');

  if (env.isEmpty) {
    throw ErrorDescription(
      'Environment isn\'t configured \r\n'
      'set-up environment by dart-define \r\n'
      'Example: flutter run --dart-define=ENV=dev',
    );
  }

  await dotenv.load(fileName: _envFiles[env]!);

  return init(getIt, environment: env);
}
