import 'package:cw_bank_credit/presentation/router/app_router.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/custom_indicator_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/auth_cubit.dart';
import '../../logic/states/auth_states.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/custom_button.dart';
import '../widgets/utils/email_form_field.dart';
import '../widgets/utils/password_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state.authStatus == AuthStatus.successLogin) {
          Navigator.pushNamed(context, Routes.creditSimulatorPage);
        } else if (state.authStatus == AuthStatus.failureLogin) {
          String errorMessage =
              state.error ?? 'Ocurrió un error. Por favor inténtalo de nuevo.';

          Center(
            child: TextView(
              text: errorMessage,
              color: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            EmailFormField(
              onChange: (String? value, bool valid) {
                setState(() => email = valid ? value : null);
              },
            ),
            const SizedBox(height: 10),
            PasswordFormField(
              onChange: (String? value, bool valid) {
                setState(() => password = valid ? value : null);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Theme(
                      data: ThemeData(
                          unselectedWidgetColor:
                              const Color.fromARGB(255, 201, 201, 201)),
                      child: Checkbox(
                        tristate: false,
                        hoverColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        activeColor: const Color.fromARGB(255, 84, 40, 241),
                        value: isSelected,
                        onChanged: (_) =>
                            setState(() => isSelected = !isSelected),
                      ),
                    ),
                    const TextView(
                      text: 'Recordarme',
                      fontWeight: FontWeight.w300,
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const TextView(
                    text: 'Olvidaste tu password?',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 40, 241),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state.authStatus == AuthStatus.loading) {
          return const CustomIndicatorProgress();
        } else {
          return CustomButton(
            text: 'Iniciar sesion',
            onPressed: () {
              _submitForm();
              Navigator.pushNamed(context, Routes.creditSimulatorPage);
            },
          );
        }
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().login(email!, password!);
    }
  }
}
