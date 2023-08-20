import 'dart:ui';

import 'package:cw_bank_credit/presentation/widgets/utils/custom_alert_dialog.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/custom_indicator_progress.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/text_view.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/custom_button.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/name_form_field.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/success_registration_modal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user.dart';
import '../../logic/cubits/auth_cubit.dart';
import '../../logic/cubits/user_cubit.dart';
import '../../logic/states/user_states.dart';
import '../widgets/utils/email_form_field.dart';
import '../widgets/utils/id_number_form_field.dart';
import '../widgets/utils/password_form_field.dart';
import '../widgets/utils/terms_condition_modal.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool isSelected = false;
  final _formKey = GlobalKey<FormState>();
  String? fullname;
  String? idNumber;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (BuildContext context, UserState state) {
        if (state.userStatus == UserStatus.createSuccess) {
          context.read<AuthCubit>().login(email!, password!);
        } else if (state.userStatus == UserStatus.createFailure) {
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
            NameFormField(
              onFieldSubmitted: (_) => _submitForm(),
              onChange: (String? value, bool valid) {
                setState(() => fullname = valid ? value : null);
              },
            ),
            const SizedBox(height: 10),
            IdNumberFormField(
              onFieldSubmitted: (_) => _submitForm(),
              onChange: (String? value, bool valid) {
                setState(() => idNumber = valid ? value : null);
              },
            ),
            const SizedBox(height: 10),
            EmailFormField(
              onFieldSubmitted: (_) => _submitForm(),
              onChange: (String? value, bool valid) {
                setState(() => email = valid ? value : null);
              },
            ),
            const SizedBox(height: 10),
            PasswordFormField(
              onFieldSubmitted: (_) => _submitForm(),
              onChange: (String? value, bool valid) {
                setState(() => password = valid ? value : null);
              },
            ),
            const SizedBox(
              height: 30,
            ),
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
                    onChanged: (_) => setState(() => isSelected = !isSelected),
                  ),
                ),
                Expanded(child: termsAndConditionText()),
              ],
            ),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state.userStatus == UserStatus.loading) {
          return const Center(
            child: CustomIndicatorProgress(),
          );
        } else {
          return CustomButton(
            text: 'Continuar',
            onPressed: () {
              if (!isSelected) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const CustomAlertDialog(
                    header: TextView(
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w900,
                      text:
                          'Debes aceptar los términos y condiciones para continuar.',
                      color: Colors.black,
                    ),
                    displayDuration: 3,
                    content: Icon(
                      CupertinoIcons.exclamationmark_octagon,
                      size: 60,
                      color: Color.fromARGB(255, 84, 40, 241),
                    ),
                  ),
                );
              } else if (_canSubmitForm()) {
                _submitForm();
                showDialog(
                  context: context,
                  builder: (context) => const SuccessRegistrationModalPage(),
                );
              }
            },
          );
        }
      },
    );
  }

  bool _canSubmitForm() {
    return fullname != null && password != null && email != null && isSelected;
  }

  User _buildUser() {
    return User(
      fullname: fullname!,
      idNumber: idNumber!,
      email: email!,
      password: password!,
    );
  }

  void _submitForm() {
    User user = _buildUser();
    context.read<UserCubit>().create(user);
  }

  Widget termsAndConditionText() => RichText(
        text: TextSpan(
            text: 'Acepto los ',
            style: const TextStyle(
                fontFamily: 'ProductSans',
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w300),
            children: [
              TextSpan(
                  text: 'Términos ',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 84, 40, 241)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => showTermsDialog()),
              const TextSpan(text: 'y '),
              TextSpan(
                text: 'Condiciones ',
                style: const TextStyle(color: Color.fromARGB(255, 84, 40, 241)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => showTermsDialog(),
              ),
              const TextSpan(text: 'y la '),
              TextSpan(
                text: 'Política de privacidad ',
                style: const TextStyle(color: Color.fromARGB(255, 84, 40, 241)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => showTermsDialog(),
              ),
              const TextSpan(text: 'de Banca de créditos'),
            ]),
      );

  void showTermsDialog() => showDialog(
      context: context,
      builder: (_) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const AlertDialog(
              title: TextView(
                  text: 'Términos y Condiciones',
                  textAlign: TextAlign.center,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              content: TermsConditionContent(),
            ),
          ));
}
