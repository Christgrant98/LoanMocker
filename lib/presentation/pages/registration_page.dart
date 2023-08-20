import 'package:cw_bank_credit/presentation/layout.dart';
import 'package:cw_bank_credit/presentation/router/app_router.dart';
import 'package:flutter/material.dart';

import '../forms/registration_form.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/auth_text_rich.dart';
import '../widgets/utils/title_logo_widget.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        body: Align(
          alignment: Alignment.topCenter,
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: constraints.maxWidth * .8,
                child: Column(
                  children: [
                    const TitleLogoWidget(),
                    const SizedBox(height: 25),
                    registrationHeader(),
                    const SizedBox(height: 25),
                    const RegistrationForm(),
                    const SizedBox(height: 15),
                    AuthTextRich(
                      questionText: 'Ya tienes una cuenta? ',
                      actionLinkText: 'Inicia sesion',
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.loginPage),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget registrationHeader() {
    return const Column(
      children: [
        TextView(
            text: 'Regístrate',
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold),
        SizedBox(height: 2.5),
        TextView(
            text: 'Solo te tomará unos minutos.',
            color: Color.fromARGB(255, 189, 199, 232),
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
