import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loanMocker/data/models/loan.dart';
import 'package:loanMocker/logic/cubits/loan_cubit.dart';
import 'package:loanMocker/presentation/widgets/utils/currency_format_text.dart';
import 'package:loanMocker/presentation/widgets/utils/text_view.dart';

class CreditHistoryContent extends StatelessWidget {
  const CreditHistoryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final savedLoans = context.select(
      (LoanCubit loanCubit) => loanCubit.state.loansData,
    );
    return Column(
      children: [
        const SizedBox(height: 100),
        historyPageHeader(),
        const SizedBox(height: 20),
        Table(
          border: const TableBorder(
            bottom: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 220, 224, 227),
            ),
            horizontalInside: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 220, 224, 227),
            ),
            verticalInside: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 220, 224, 227),
            ),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: _buildRows(savedLoans),
        ),
        const SizedBox(height: 25),
        Center(
          child: RichText(
            text: const TextSpan(
              text: 'No hay mas datos por mostrar ',
              style: TextStyle(
                  fontFamily: 'ProductSans',
                  color: Color.fromARGB(255, 177, 177, 177),
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
              children: [
                TextSpan(text: 'ⓘ'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<TableRow> _buildRows(List<Loan> loans) {
    final rows = <TableRow>[
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildTableCell(text: 'Monto de Crédito'),
          ),
          _buildTableCell(text: 'No. de Cuotas'),
          _buildTableCell(text: 'Interés'),
          _buildTableCell(text: 'Acciones'),
        ],
      ),
    ];

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
            _buildTableCell(
              text: loan.loanTerm.toString(),
            ),
            _buildTableCell(
                text: '${(loan.creditRate * 100).toStringAsFixed(1)}%'),
            _buildTableCell(
              text: loan.loanTerm.toString(),
            ),
            TableCell(
              child: Center(child: _buildActionBttn()),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  Widget _buildTableCell({
    required String text,
  }) {
    return TableCell(
      child: Center(
        child: TextView(
          fontWeight: FontWeight.bold,
          text: text,
          textAlign: TextAlign.center,
          fontSize: 12,
        ),
      ),
    );
  }

  InkWell _buildActionBttn() {
    return InkWell(
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
}
