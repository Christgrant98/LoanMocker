import 'package:cw_bank_credit/logic/cubits/loan_cubit.dart';
import 'package:cw_bank_credit/logic/states/loan_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/loan.dart';
import '../layout.dart';
import '../widgets/utils/settings_button.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/bottom_navigator_menu.dart';

class CreditSimulationResultsPage extends StatelessWidget {
  const CreditSimulationResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: SizedBox(
              width: constraints.maxWidth * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  creditSimulatorResultHeader(),
                  SizedBox(
                    width: constraints.maxWidth * .85,
                    child: _buildTable(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavigator(),
      );
    });
  }

  Widget creditSimulatorResultHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: TextView(
                  text: 'Resultado de tu simulador de credito',
                  color: Color.fromARGB(255, 84, 40, 241),
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
            SizedBox(
              width: 100,
              child: SvgPicture.asset(
                'assets/bell_icon.svg',
                alignment: Alignment.topRight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const TextView(
            text:
                'Te presentamos en tu table de amortizacion el resultado del movimiento de tu credito.',
            fontWeight: FontWeight.w300,
            fontSize: 16),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
                text: 'Tabla de creditos',
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 20),
            SettingsButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildTable() {
    return BlocBuilder<LoanCubit, LoanState>(
      builder: (context, state) {
        if (state.loan == null) return Container();
        return Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: _buildRows(state.loan!),
        );
      },
    );
  }

  List<TableRow> _buildRows(Loan loan) {
    List<TableRow> rows = [];
    double installment = loan.calculateInstallment();
    int installmentNumber = 0;
    double balance = loan.loanAmount;
    while (balance > 0) {
      installmentNumber++;
      double initialBalance = balance;
      double interest = balance * loan.creditRate;
      double principalPayment = installment - interest;
      balance -= principalPayment;

      List<TableCell> cells = [];
      for (int i = 0; i < 6; i++) {
        if (i == 0) {
          cells.add(
            TableCell(child: Text(initialBalance.toString())),
          );
        } else if (i == 1) {
          cells.add(
            TableCell(child: Text(installmentNumber.toString())),
          );
        } else if (i == 2) {
          cells.add(
            TableCell(child: Text(installment.toString())),
          );
        } else if (i == 3) {
          cells.add(
            TableCell(child: Text(interest.toString())),
          );
        } else if (i == 4) {
          cells.add(
            TableCell(child: Text(principalPayment.toString())),
          );
        } else if (i == 5) {
          cells.add(
            TableCell(child: Text(balance.toString())),
          );
        }
      }
      TableRow row = TableRow(children: cells);
      rows.add(row);
    }
    return rows;
  }
}
