import 'package:cw_bank_credit/presentation/widgets/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../router/app_router.dart';
import 'text_view.dart';

class SuccessRegistrationModalPage extends StatelessWidget {
  const SuccessRegistrationModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: maxWidth * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/success_registration.svg',
              ),
              const SizedBox(height: 20),
              const TextView(
                  text: 'Registro exitoso',
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              const SizedBox(height: 15),
              const TextView(
                  text:
                      'Hemos guardado tus credenciales de forma exitosa. Presiona continuar para seguir adelante.',
                  textAlign: TextAlign.center,
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 25),
              CustomButton(
                  text: 'Continuar',
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, Routes.creditSimulatorPage))
            ],
          ),
        ),
      ),
    );
  }
}
