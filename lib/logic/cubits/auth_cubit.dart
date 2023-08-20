import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user.dart';
import '../states/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      if (state.user?.password == password) {
        emit(state.copyWith(
          authStatus: AuthStatus.successLogin,
          user: state.user,
        ));
      } else {
        emit(state.copyWith(
          authStatus: AuthStatus.failureLogin,
          error: 'Credenciales incorrectas',
        ));
      }
    } catch (error) {
      String errorMessage = error.toString();
      emit(state.copyWith(
        authStatus: AuthStatus.failureLogin,
        error: errorMessage,
      ));
    }
  }

  Future<void> create(User user) async {
    emit(
      state.copyWith(authStatus: AuthStatus.loading),
    );
    try {
      emit(
        state.copyWith(authStatus: AuthStatus.sucessCreate, user: user),
      );
    } catch (error) {
      emit(state.copyWith(
          authStatus: AuthStatus.failureCreate, error: error.toString()));
    }
  }
}
