import 'package:loanMocker/logic/cubits/loan_cubit.dart';
import 'package:loanMocker/presentation/widgets/utils/base_salary_form_field.dart';
import 'package:loanMocker/presentation/widgets/utils/credit_type_form_field.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_button.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_modal_bottom_sheet.dart';
import 'package:loanMocker/presentation/widgets/utils/loan_amount_form_field.dart';
import 'package:loanMocker/presentation/widgets/utils/xmark_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/loan.dart';
import '../router/app_router.dart';
import '../widgets/utils/currency_format_text.dart';
import '../widgets/utils/loading_modal_page.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/loan_term_form_field.dart';

class CreditSimulatorForm extends StatefulWidget {
  const CreditSimulatorForm({Key? key}) : super(key: key);

  @override
  State<CreditSimulatorForm> createState() => _CreditSimulatorFormState();
}

class _CreditSimulatorFormState extends State<CreditSimulatorForm> {
  final _formKey = GlobalKey<FormState>();
  double? loanAmount;

  Map<String, double> creditRates = {
    'Vehicle Credit': 0.03,
    'Home Credit': 0.01,
    'Personal Investment Credit': 0.035,
  };
  double? creditRate;
  double? baseSalary;
  int? loanTerm;
  double? suggestedLoanAmount;

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
              setState(() {
                baseSalary = value == null ? null : double.tryParse(value);
              });
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
          CustomButton(
            text: 'Simulate',
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
        builder: (context) => CustomModalBottomSheet(
          content: loanPreviewContent(),
        ),
      );

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
    double installment = loan!.calculateInstallment();
    double convertedRate = loan.calculateTEA();
    double creditRate = loan.creditRate * 100;
    double loanAmount = loan.loanAmount;
    double loanTotalAmount = loan.calculateTotalLoan();

    return SingleChildScrollView(
      child: Stack(
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
                        text: 'Maximum Loan Installment',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                      const SizedBox(height: 10),
                      CurrencyFormattedText(
                        amount: installment,
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      ),
                      const SizedBox(height: 10),
                      const TextView(
                        text:
                            '*This value usually changes with respect to your salary',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromARGB(255, 0, 90, 126),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                      text: 'Annual Effective Rate from',
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                    TextView(
                      text: '${convertedRate.toStringAsFixed(2)}%',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                      text: 'Monthly Rate in Arrears from',
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                    TextView(
                      text: '${creditRate.toStringAsFixed(1)}%',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                      text: 'Total Loan Amount',
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                    CurrencyFormattedText(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      amount: loanAmount,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromARGB(255, 223, 223, 223),
                  thickness: 1,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                      text: 'Total Amount to Pay',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                    CurrencyFormattedText(
                      amount: loanTotalAmount,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
                const SizedBox(height: 7.5),
                const TextView(
                  text: '(principal = interest = insurance)',
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    _showLoadingModal(context);

                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).pop();
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
      ),
    );
  }
}
