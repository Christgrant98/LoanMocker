import 'package:cw_bank_credit/presentation/pages/credit_simulator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/auth_cubit.dart';
import '../../logic/cubits/loan_cubit.dart';
import '../../logic/cubits/navigation_cubit.dart';
import '../pages/credit_simulator_result_page.dart';
import '../pages/login_page.dart';
import '../pages/registration_page.dart';

class Routes {
  static const String registrationPage = 'registration';
  static const String loginPage = 'login';
  static const String testPage = 'test';
  static const String creditSimulatorPage = 'creditSimulator';
  static const String creditSimulatorPageResult = 'creditSimulatorPageResult';
}

class AppRouter {
  final NavigationCubit _navigationCubit = NavigationCubit();
  final LoanCubit _loanCubit = LoanCubit();
  final AuthCubit authCubit;

  AppRouter({required this.authCubit});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.registrationPage:
        _navigationCubit.setSelectedIndex(3);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const RegistrationPage(),
          ),
        );
      case Routes.creditSimulatorPageResult:
        _navigationCubit.setSelectedIndex(0);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _navigationCubit),
              BlocProvider.value(
                value: _loanCubit,
              )
            ],
            child: const CreditSimulationResultsPage(),
          ),
        );
      case Routes.creditSimulatorPage:
        _navigationCubit.setSelectedIndex(0);
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _navigationCubit),
                    BlocProvider.value(value: _loanCubit),
                  ],
                  child: const CreditSimulatorPage(),
                ));
      default:
        _navigationCubit.setSelectedIndex(4);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const LoginPage(),
          ),
        );
    }
  }
}
