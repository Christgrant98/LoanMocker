import 'package:flutter/material.dart';

import '../../../data/models/loan.dart';
import 'currency_format_text.dart';
import 'text_view.dart';

class SimulatorTable extends StatelessWidget {
  final Loan loan;
  const SimulatorTable({
    super.key,
    required this.loan,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: _buildTableBorderStyles(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _buildRows(loan),
    );
  }

  List<TableRow> _buildRows(Loan loan) {
    List<TableRow> rows = [];
    List<TableCell> headerCells = [];
    for (int i = 0; i < 6; i++) {
      if (i == 0) {
        headerCells.add(
          _buildTableCellHeader(text: 'Saldo inicial'),
        );
      } else if (i == 1) {
        headerCells.add(
          _buildTableCellHeader(text: 'No. cuotas'),
        );
      } else if (i == 2) {
        headerCells.add(
          _buildTableCellHeader(text: 'Cuota'),
        );
      } else if (i == 3) {
        headerCells.add(
          _buildTableCellHeader(text: 'Intereses'),
        );
      } else if (i == 4) {
        headerCells.add(
          _buildTableCellHeader(text: 'Abono Capital'),
        );
      } else if (i == 5) {
        headerCells.add(
          _buildTableCellHeader(text: 'Saldo del periodo'),
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
                  amount: balance, fontSize: 8, textAlign: TextAlign.center),
            ),
          );
        }
      }
      TableRow row =
          TableRow(children: cells, decoration: const BoxDecoration());
      rows.add(row);
    }
    return rows;
  }

  TableCell _buildTableCellHeader({
    required String text,
  }) {
    return const TableCell(
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
    );
  }

  TableBorder _buildTableBorderStyles() {
    return const TableBorder(
      bottom: BorderSide(width: 1, color: Color.fromARGB(255, 220, 224, 227)),
      horizontalInside:
          BorderSide(width: 1, color: Color.fromARGB(255, 220, 224, 227)),
      verticalInside: BorderSide(
        width: 1,
        color: Color.fromARGB(255, 220, 224, 227),
      ),
    );
  }
}
