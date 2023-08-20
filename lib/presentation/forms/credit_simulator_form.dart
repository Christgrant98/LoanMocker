import 'package:cw_bank_credit/logic/cubits/loan_cubit.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/base_salary_form_field.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/credit_type_form_field.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/custom_button.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/custom_modal_bottom_sheet.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/loan_amount_form_field.dart';
import 'package:cw_bank_credit/presentation/widgets/utils/xmark_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/loan.dart';
import '../../logic/states/loan_state.dart';
import '../router/app_router.dart';
import '../widgets/utils/loading_modal_page.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/loan_term_form_field.dart';

class CreditSimulatorForm extends StatefulWidget {
  const CreditSimulatorForm({super.key});

  @override
  State<CreditSimulatorForm> createState() => _CreditSimulatorFormState();
}

class _CreditSimulatorFormState extends State<CreditSimulatorForm> {
  final _formKey = GlobalKey<FormState>();
  double? loanAmount;

  Map<String, double> creditRates = {
    'Crédito de vehiculo': 0.03,
    'Crédito de vivienda': 0.01,
    'Crédito de libre inversión': 0.035,
  };
  double? creditRate;
  double? baseSalary;
  int? loanTerm;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CreditTypeFormField(
            creditTypes: creditRates.keys.toList(),
            creditRates: creditRates,
            onChange: (String? value, double? rate) {
              setState(() {
                creditRate = rate;
              });
            },
          ),
          const SizedBox(height: 10),
          BaseSalaryFormField(
            onValueChange: (String? value, bool valid) {
              setState(
                () =>
                    baseSalary = value == null ? null : double.tryParse(value),
              );
            },
          ),
          const SizedBox(height: 10),
          LoanAmountFormField(
            onChange: (String? value, bool valid) {
              setState(() {
                loanAmount = value == null ? null : double.tryParse(value);
              });
            },
          ),
          const SizedBox(height: 10),
          LoanTermFormField(
            onChange: (String? value, bool valid) =>
                loanTerm = value == null ? null : int.tryParse(value),
          ),
          const SizedBox(height: 25),
          if (_canBuildLoan())
            CustomButton(
              text: 'Simular',
              onPressed: () {
                _buildModalLoanPreview();
                context.read<LoanCubit>().setLoan(_buildLoan());
                // Navigator.pushReplacementNamed(
                //     context, Routes.creditSimulatorPageResult);
              },
            )
        ],
      ),
    );
  }

  bool _canBuildLoan() {
    return loanAmount != null &&
        baseSalary != null &&
        loanTerm != null &&
        creditRate != null;
  }

  _buildLoan() {
    return Loan(
      loanAmount: loanAmount!,
      baseSalary: baseSalary!,
      loanTerm: loanTerm!,
      creditRate: creditRate!,
    );
  }

  _buildModalLoanPreview() => showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black,
      context: context,
      constraints: const BoxConstraints(),
      builder: (context) =>
          CustomModalBottomSheet(content: loanPreviewContent()));

  void _showLoadingModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LoadingModalPage();
      },
    );
  }

  Widget loanPreviewContent() {
    final Loan? loan = context.watch<LoanCubit>().state.loan;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: 'Cuota maxima de prestamo',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                    const SizedBox(height: 10),
                    // TODO: ALLOCATE TRUE VALUES
                    TextView(
                      text: '\$${loan!.loanAmount.toStringAsFixed(2)}',
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                    const SizedBox(height: 10),
                    const TextView(
                        text:
                            '*Este valor suele cambiar con respecto a tu salario',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromARGB(255, 84, 40, 241)),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: 'Tasa Efectiva Anual desde',
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                  // TODO: ALLOCATE TRUE VALUES
                  TextView(
                    text: '43.26%',
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: 'Tasa Mensual Vencida desde',
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                  // TODO: ALLOCATE TRUE VALUES
                  TextView(
                    text: '3.04%',
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: 'Valor total prestamo',
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                  // TODO: ALLOCATE TRUE VALUES
                  TextView(
                    text: '\$950',
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Color.fromARGB(255, 223, 223, 223),
                thickness: 1,
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: 'Valor total a pagar',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                  // TODO: ALLOCATE TRUE VALUES
                  TextView(
                    text: '\$1.112.501',
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
              const SizedBox(height: 7.5),
              const TextView(
                text: '(capital = intereses = seguro)',
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Continuar',
                onPressed: () {
                  _showLoadingModal(context);

                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context).pop(); // Cerrar el modal de carga
                    Navigator.pushReplacementNamed(
                        context, Routes.creditSimulatorPageResult);
                  });
                },
              ),
            ],
          ),
        ),
        const Positioned(
          right: 10,
          top: 10,
          child: XmarkButton(),
        ),
      ],
    );
  }
}
