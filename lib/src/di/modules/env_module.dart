import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

const _apiEndPoint = 'API_ENDPOINT';

@module
abstract class EnvModule {
  @Named(_apiEndPoint)
  String get apiEndpoint => dotenv.env[_apiEndPoint]!;
}
