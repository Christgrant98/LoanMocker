import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loanMocker/data/models/loan.dart';
import 'package:loanMocker/logic/cubits/loan_cubit.dart';
import 'package:loanMocker/presentation/widgets/utils/currency_format_text.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_button.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_modal_bottom_sheet.dart';
import 'package:loanMocker/presentation/widgets/utils/modal_view.dart';
import 'package:loanMocker/presentation/widgets/utils/simulator_table.dart';
import 'package:loanMocker/presentation/widgets/utils/text_view.dart';

import 'xmark_button.dart';

class CreditHistoryContent extends StatelessWidget {
  const CreditHistoryContent({
    Key? key,
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
              text: 'No more data to show ',
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
          _buildTableCell(text: 'Loan Amount'),
          _buildTableCell(text: 'Number of Installments'),
          _buildTableCell(text: 'Interest'),
          _buildTableCell(text: 'Actions'),
        ],
      ),
    ];

    for (final loan in loans) {
      List<Loan> allLoans = context.watch<LoanCubit>().state.loansData;
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
                child: InkWell(
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
                      barrierColor: Colors.black38,
                      constraints: const BoxConstraints(),
                      context: context,
                      builder: (context) {
                        return _buildBottomContentModal(
                          context: context,
                          loans: allLoans,
                          selectedIndex: loans.indexOf(loan),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  CustomModalBottomSheet _buildBottomContentModal({
    required BuildContext context,
    required List<Loan> loans,
    required int selectedIndex,
  }) {
    Loan currentLoan = loans[selectedIndex];

    return CustomModalBottomSheet(
      blurredIdx: 0,
      height: 300,
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextView(
              text: 'Table Actions',
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
              text: 'View Content',
              onPressed: () {
                showDialog(
                    barrierColor: const Color.fromARGB(134, 0, 70, 97),
                    context: context,
                    builder: (BuildContext context) {
                      return ModalView(
                        paddingValue: 7.5,
                        heightFactor: .75,
                        widthFactor: .9,
                        content: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: TextView(
                                      text:
                                          'Credit Content #${selectedIndex + 1}',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SimulatorTable(
                                    loan: currentLoan,
                                  ),
                                ],
                              ),
                              const Positioned(
                                right: 0,
                                top: 0,
                                child: XmarkButton(),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Download Table',
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
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

  Widget historyPageHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          fontWeight: FontWeight.bold,
          text: 'Credit History',
          fontSize: 25,
        ),
        SizedBox(height: 20),
        TextView(
          fontWeight: FontWeight.w300,
          text:
              'Here you will find your credit history and the record of all your simulations',
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
