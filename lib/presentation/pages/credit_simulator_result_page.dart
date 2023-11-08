import 'package:loanMocker/logic/cubits/loan_cubit.dart';
import 'package:loanMocker/logic/states/loan_state.dart';
import 'package:loanMocker/presentation/widgets/utils/currency_format_text.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/loan.dart';
import '../layout.dart';
import '../router/app_router.dart';
import '../widgets/utils/custom_modal_bottom_sheet.dart';
import '../widgets/utils/settings_button.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/bottom_navigator_menu.dart';
import '../widgets/utils/xmark_button.dart';

class CreditSimulationResultsPage extends StatelessWidget {
  const CreditSimulationResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Loan? loan = context.watch<LoanCubit>().state.loan;
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
                  const SizedBox(height: 20),
                  CustomButton(onPressed: () {}, text: 'Descargar tabla'),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.black,
                          context: context,
                          constraints: const BoxConstraints(),
                          builder: (_) => CustomModalBottomSheet(
                                  content: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .7,
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 20),
                                                Icon(
                                                  CupertinoIcons
                                                      .exclamationmark_octagon,
                                                  size: 80,
                                                  color: Color.fromARGB(
                                                      255, 84, 40, 241),
                                                ),
                                                SizedBox(height: 20),
                                                TextView(
                                                  text:
                                                      'Esta seguro que desea Guardar la cotizacion?',
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 25,
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 20),
                                                TextView(
                                                  text:
                                                      'La cotizacion realizada la podras consultar en tu historial de creditos.',
                                                  fontWeight: FontWeight.w300,
                                                  textAlign: TextAlign.center,
                                                  fontSize: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        CustomButton(
                                          text: 'Guardar',
                                          onPressed: () {
                                            context
                                                .read<LoanCubit>()
                                                .saveLoanData(loan!);
                                            Navigator.pushReplacementNamed(
                                                context,
                                                Routes.creditHistoryPage);
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        CustomButton(
                                          text: 'Cancelar',
                                          isAppColor: false,
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  const Positioned(
                                    right: 10,
                                    top: 10,
                                    child: XmarkButton(),
                                  ),
                                ],
                              )));

                      // _buildModalLoanPreview(context);
                    },
                    text: 'Guardar cotizacion',
                    isAppColor: false,
                  ),
                  const SizedBox(height: 20),
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
                  color: Color.fromARGB(255, 0, 90, 126),
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 15,
            ),
            Table(
              border: const TableBorder(
                  bottom: BorderSide(
                      width: 1, color: Color.fromARGB(255, 220, 224, 227)),
                  horizontalInside: BorderSide(
                      width: 1, color: Color.fromARGB(255, 220, 224, 227)),
                  verticalInside: BorderSide(
                      width: 1, color: Color.fromARGB(255, 220, 224, 227))),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: _buildRows(state.loan!),
            ),
          ],
        );
      },
    );
  }

  List<TableRow> _buildRows(Loan loan) {
    List<TableRow> rows = [];
    List<TableCell> headerCells = [];
    for (int i = 0; i < 6; i++) {
      if (i == 0) {
        headerCells.add(
          const TableCell(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: TextView(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                    text: 'Saldo inicial'),
              ),
            ),
          ),
        );
      } else if (i == 1) {
        headerCells.add(
          const TableCell(
            child: Center(
              child: TextView(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  text: 'No. cuotas'),
            ),
          ),
        );
      } else if (i == 2) {
        headerCells.add(
          const TableCell(
            child: Center(
              child: TextView(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  text: 'Cuota'),
            ),
          ),
        );
      } else if (i == 3) {
        headerCells.add(
          const TableCell(
            child: Center(
              child: TextView(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  text: 'Interes'),
            ),
          ),
        );
      } else if (i == 4) {
        headerCells.add(
          const TableCell(
            child: Center(
              child: TextView(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  text: 'Abono Capital'),
            ),
          ),
        );
      } else if (i == 5) {
        headerCells.add(
          const TableCell(
            child: Center(
              child: TextView(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  text: 'Saldo del periodo'),
            ),
          ),
        );
      }
    }
    rows.add(TableRow(children: headerCells));
    double installment = loan.calculateInstallment();
    int loanTerm = 0;
    double balance = loan.loanAmount;
    while (balance > 0) {
      loanTerm++;
      double initialBalance = balance;
      double interest = balance * loan.creditRate;
      double principalPayment = installment - interest;
      balance -= principalPayment;

      List<TableCell> cells = [];
      for (int i = 0; i < 6; i++) {
        if (i == 0) {
          cells.add(
            TableCell(
                child: CurrencyFormattedText(
              amount: initialBalance,
              fontSize: 8,
              textAlign: TextAlign.center,
            )),
          );
        } else if (i == 1) {
          cells.add(
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextView(
                text: loanTerm.toString(),
                fontSize: 8,
                textAlign: TextAlign.center,
              ),
            )),
          );
        } else if (i == 2) {
          cells.add(
            TableCell(
                child: CurrencyFormattedText(
                    amount: installment,
                    fontSize: 8,
                    color: const Color.fromARGB(255, 171, 174, 176),
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.center)),
          );
        } else if (i == 3) {
          cells.add(
            TableCell(
              child: CurrencyFormattedText(
                  amount: interest, fontSize: 8, textAlign: TextAlign.center),
            ),
          );
        } else if (i == 4) {
          cells.add(
            TableCell(
                child: CurrencyFormattedText(
              amount: principalPayment,
              fontSize: 8,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            )),
          );
        } else if (i == 5) {
          cells.add(
            TableCell(
                child: CurrencyFormattedText(
                    amount: balance, fontSize: 8, textAlign: TextAlign.center)),
          );
        }
      }
      TableRow row =
          TableRow(children: cells, decoration: const BoxDecoration());
      rows.add(row);
    }
    return rows;
  }
}
