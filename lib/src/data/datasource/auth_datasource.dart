import 'package:dio/dio.dart';
import 'package:flutter_redrocket_test_task/src/data/entity/login_request.dart';
import 'package:flutter_redrocket_test_task/src/data/entity/login_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_datasource.g.dart';

@RestApi()
abstract class AuthDatasource {
  @POST('/login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET('/logout')
  Future<void> logout();
}

@module
abstract class AuthDatasourceModule {
  @LazySingleton(env: ['dev'])
  AuthDatasource authDatasource(@Named('API_ENDPOINT') String apiEndpoint) {
    final dio = Dio(BaseOptions(headers: {"Content-Type": "application/json"}));

    return _AuthDatasource(dio, baseUrl: apiEndpoint);
  }
}
