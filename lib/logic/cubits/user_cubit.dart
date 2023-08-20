import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user.dart';
import '../states/user_states.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState.initial());

  Future<void> create(User user) async {
    emit(state.copyWith(userStatus: UserStatus.loading));

    try {
      List<User> users = List.from(state.users)..add(user);
      emit(
        state.copyWith(userStatus: UserStatus.createSuccess, users: users),
      );
    } catch (error) {
      emit(state.copyWith(
          userStatus: UserStatus.createFailure, error: error.toString()));
    }
  }

  User getUserByEmail(String email) {
    User rawUser = state.users.firstWhere((user) => user.email == email);
    return rawUser;
  }
}
