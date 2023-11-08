import 'package:loanMocker/presentation/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubits/auth_cubit.dart';
import 'presentation/router/app_router.dart';

// app colors
// purple -> Color.fromARGB(255, 0, 90, 126),
// gray -> Color.fromARGB(255, 216, 216, 216),
// Color.fromARGB(255, 0, 90, 126)

void main() {
  AuthCubit authCubit = AuthCubit();
  AppRouter appRouter = AppRouter(authCubit: authCubit);
  runApp(
    BlocProvider<AuthCubit>(
      create: (_) => authCubit,
      child: MyApp(
        appRouter: appRouter,
      ),
    ),
  );
}
