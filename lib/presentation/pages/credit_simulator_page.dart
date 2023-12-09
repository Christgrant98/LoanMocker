import 'package:loanMocker/presentation/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/user.dart';
import '../../logic/cubits/auth_cubit.dart';
import '../forms/credit_simulator_form.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/bottom_navigator_menu.dart';

class CreditSimulatorPage extends StatelessWidget {
  const CreditSimulatorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<AuthCubit>().state.user;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Layout(
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: SizedBox(
                width: constraints.maxWidth * .9,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: 'Hello ${currentUser?.fullname}👋',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            SvgPicture.asset('assets/bell_icon.svg'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: const TextSpan(
                            text: 'Credit Simulator ',
                            style: TextStyle(
                              fontFamily: 'ProductSans',
                              color: Color.fromARGB(255, 0, 90, 126),
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                            children: [
                              TextSpan(text: 'ⓘ'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const TextView(
                          text:
                              'Enter the details for your credit according to your needs.',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: constraints.maxWidth * .85,
                      child: const CreditSimulatorForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavigator(),
        );
      },
    );
  }
}
