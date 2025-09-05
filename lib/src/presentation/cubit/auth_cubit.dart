import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/auth_status.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/exception/auth_exception.dart';
import 'package:flutter_redrocket_test_task/src/domain/repository/auth_repository.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth_state.dart';
import 'package:flutter_redrocket_test_task/src/presentation/utils/login_mixin.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthCubit extends Cubit<AuthState> with LoggerMixin {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState.initial());

  Future<void> onCreate() async {
    logger.i('onCreate');

    try {
      final authStatus = await _authRepository.getAuthStatus();

      switch (authStatus) {
        case AuthStatus.authroized:
          emit(const AuthState.authenticated());
        default:
          emit(const AuthState.unauthenticated());
      }
    } catch (exception) {
      logger.e('while onCreate caught unexpected $exception');
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    logger.i('logIn email=$email password=$password');

    try {
      emit(const AuthState.loading());
      await _authRepository.logIn(email: email, password: password);

      emit(const AuthState.authenticated());
    } on AccountNotFoundException {
      logger.i('while onCreate caught unexpected AccountNotFoundException');

      emit(const AuthState.error(message: 'Account not found'));
      emit(const AuthState.unauthenticated());
    } on BadCredentialFormatException {
      logger.i('while onCreate caught unexpected BadCredentialFormatException');

      emit(const AuthState.error(message: 'Bad credentials fromat'));
      emit(const AuthState.unauthenticated());
    } on WrongCredentialException {
      logger.i('while onCreate caught unexpected WrongCredentialException');

      emit(const AuthState.error(message: 'Wrong login or password'));
      emit(const AuthState.unauthenticated());
    } catch (exception) {
      logger.e('while onCreate caught unexpected $exception');

      emit(const AuthState.error(message: 'Something went wrong'));
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> logOut() async {
    logger.i('logOut');

    try {
      await _authRepository.logOut();
    } catch (exception) {
      logger.e('while logOut caught unexpected $exception ');
    } finally {
      emit(const AuthState.unauthenticated());
    }
  }
}
