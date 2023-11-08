import 'package:loanMocker/presentation/layout.dart';
import 'package:flutter/material.dart';

import '../forms/login_form.dart';
import '../router/app_router.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/auth_text_rich.dart';
import '../widgets/utils/title_logo_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: SizedBox(
              width: constraints.maxWidth * .8,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Center(child: TitleLogoWidget()),
                  const SizedBox(height: 25),
                  const SizedBox(height: 2.5),
                  SizedBox(
                    width: constraints.maxWidth * .6,
                    child: const TextView(
                      text:
                          'Inicia sesion o continua, solo te tomara unos minutos',
                      textAlign: TextAlign.center,
                      color: Colors.black,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const LoginForm(),
                  const SizedBox(height: 20),
                  AuthTextRich(
                    questionText: 'No tienes una cuenta? ',
                    actionLinkText: 'Registrate',
                    onTap: () => Navigator.pushReplacementNamed(
                        context, Routes.registrationPage),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
