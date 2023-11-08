import 'package:loanMocker/presentation/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/loan.dart';
import '../../logic/cubits/loan_cubit.dart';
import '../widgets/utils/bottom_navigator_menu.dart';
import '../widgets/utils/currency_format_text.dart';
import '../widgets/utils/text_view.dart';

class CreditHistoryPage extends StatelessWidget {
  const CreditHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedLoans =
        context.select((LoanCubit loanCubit) => loanCubit.state.loansData);

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
                    const SizedBox(height: 100),
                    historyPageHeader(),
                    const SizedBox(height: 20),
                    Table(
                      border: const TableBorder(
                          bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 220, 224, 227)),
                          horizontalInside: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 220, 224, 227)),
                          verticalInside: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 220, 224, 227))),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: _buildRows(savedLoans),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: RichText(
                          text: const TextSpan(
                              text: 'No hay mas datos por mostrar ',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: Color.fromARGB(255, 177, 177, 177),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16),
                              children: [TextSpan(text: 'ⓘ')])),
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

  Widget historyPageHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          fontWeight: FontWeight.bold,
          text: 'Historial de Créditos',
          fontSize: 25,
        ),
        SizedBox(height: 20),
        TextView(
          fontWeight: FontWeight.w300,
          text:
              'Aqui encontraras tu historial de creditos y el registro de todas tus simulaiones',
          fontSize: 18,
        ),
        SizedBox(height: 5),
        Divider(
          color: Color.fromARGB(255, 223, 223, 223),
          thickness: 1,
        ),
      ],
    );
  }

  List<TableRow> _buildRows(List<Loan> loans) {
    final rows = <TableRow>[
      const TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TableCell(
              child: Center(
                child: TextView(
                  fontWeight: FontWeight.bold,
                  text: 'Monto de Crédito',
                  textAlign: TextAlign.center,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          TableCell(
            child: Center(
              child: TextView(
                fontWeight: FontWeight.bold,
                text: 'No. de Cuotas',
                textAlign: TextAlign.center,
                fontSize: 12,
              ),
            ),
          ),
          TableCell(
            child: Center(
              child: TextView(
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                text: 'Interés',
                fontSize: 12,
              ),
            ),
          ),
          TableCell(
            child: Center(
              child: TextView(
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                text: 'Acciones',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ];

    final defaultIcon = InkWell(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.info_outline_rounded,
          size: 18,
          color: Color.fromARGB(255, 0, 90, 126),
        ),
      ),
      onTap: () {},
    );

    for (final loan in loans) {
      rows.add(
        TableRow(
          children: [
            TableCell(
              child: Center(
                  child: CurrencyFormattedText(
                amount: loan.loanAmount,
                fontSize: 10,
              )),
            ),
            TableCell(
              child: Center(
                  child: TextView(
                text: (loan.loanTerm.toString()),
                fontSize: 12,
              )),
            ),
            TableCell(
              child: Center(
                  child: TextView(
                fontSize: 12,
                text: ('${(loan.creditRate * 100).toStringAsFixed(1)}%'),
              )),
            ),
            TableCell(
              child: Center(
                child: defaultIcon,
              ),
            ),
          ],
        ),
      );
    }

    return rows;
  }
}
