import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loanMocker/data/models/loan.dart';
import 'package:loanMocker/logic/cubits/loan_cubit.dart';
import 'package:loanMocker/logic/states/loan_state.dart';
import 'package:loanMocker/presentation/widgets/utils/currency_format_text.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_button.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_modal_bottom_sheet.dart';
import 'package:loanMocker/presentation/widgets/utils/modal_view.dart';
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
        _buildTable(savedLoans, context),
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
                TextSpan(
                  text: 'ⓘ',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Table _buildTable(List<Loan> savedLoans, BuildContext context) {
    return Table(
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
      children: _buildRows(savedLoans, context),
    );
  }

  List<TableRow> _buildRows(
    List<Loan> loans,
    BuildContext context,
  ) {
    final rows = <TableRow>[
      TableRow(
        children: [
          _buildTableCell(text: 'Monto de Crédito'),
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
            TableCell(
              child: Center(
                child: _buildActionBttn(context),
              ),
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

  Widget _buildActionBttn(
    BuildContext context,
  ) {
    return InkWell(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.info_outline_rounded,
          size: 18,
          color: Color.fromARGB(255, 0, 90, 126),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black54,
          constraints: const BoxConstraints(),
          context: context,
          builder: (context) {
            return _buildBottomContentModal(context);
          },
        );
      },
    );
  }

  Widget _buildBottomContentModal(BuildContext context) {
    return CustomModalBottomSheet(
      height: 300,
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextView(
              text: 'Acciones de la Tabla',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 15),
            const Icon(
              Icons.table_view_rounded,
              size: 60,
              color: Color.fromARGB(255, 0, 90, 126),
            ),
            const SizedBox(height: 25),
            CustomButton(
              isAppColor: false,
              text: 'Ver Contenido',
              onPressed: () {
                showDialog(
                    barrierColor: Colors.black,
                    context: context,
                    builder: (context) {
                      return _buildTableContentModalView();
                    });
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Descargar Tabla',
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  ModalView _buildTableContentModalView() {
    return const ModalView(
      heightFactor: .65,
      widthFactor: .9,
      content: Column(children: [
        BlocBuilder<LoanCubit, LoanState>(
      builder: (context, state) {
        if (state.loan == null) return Container();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            SimulatorTable(
              loan: state.loan!,
            ),
          ],
        );
      },
    );
      ],),
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
