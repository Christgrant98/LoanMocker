import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:loanMocker/logic/cubits/loan_cubit.dart';
import 'package:loanMocker/logic/states/loan_state.dart';
import 'package:loanMocker/presentation/widgets/utils/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/models/loan.dart';
import '../layout.dart';
import '../router/app_router.dart';
import '../widgets/utils/custom_modal_bottom_sheet.dart';
import '../widgets/utils/settings_button.dart';
import '../widgets/utils/simulator_table.dart';
import '../widgets/utils/text_view.dart';
import '../widgets/utils/bottom_navigator_menu.dart';
import '../widgets/utils/xmark_button.dart';

class CreditSimulationResultsPage extends StatefulWidget {
  const CreditSimulationResultsPage({Key? key});

  @override
  State<CreditSimulationResultsPage> createState() =>
      _CreditSimulationResultsPageState();
}

class _CreditSimulationResultsPageState
    extends State<CreditSimulationResultsPage> {
  exportToExcel() {
    print('Starting Excel export...');
    try {
      final excel = Excel.createExcel();
      final sheet = excel.sheets[excel.getDefaultSheet() as String];

      sheet!.setColumnWidth(2, 50);
      sheet.setColumnAutoFit(3);

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3))
          .value = 'Text for test';

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 4))
          .value = 'Text for test name 2';
      excel.save();
      print('Excel export completed.');
    } catch (e) {
      print('Error exporting to Excel: $e');
    }
  }

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
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Download table',
                    onPressed: () async {
                      if (kIsWeb) {
                        exportToExcel();
                      } else {
                        var status = await Permission.storage.request();
                        if (status.isGranted) {
                          exportToExcel();
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          barrierColor: Colors.black,
                          context: context,
                          constraints: const BoxConstraints(),
                          builder: (_) =>
                              _buildBottomModalContent(context, loan));
                    },
                    text: 'Save quote',
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

  Widget _buildBottomModalContent(
    BuildContext context,
    Loan? loan,
  ) {
    return CustomModalBottomSheet(
        content: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Icon(
                        CupertinoIcons.exclamationmark_octagon,
                        size: 80,
                        color: Color.fromARGB(255, 84, 40, 241),
                      ),
                      SizedBox(height: 20),
                      TextView(
                        text: 'Are you sure you want to save the quote?',
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      TextView(
                        text:
                            'You will be able to consult the quote made in your credit history.',
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
                text: 'Save',
                onPressed: () {
                  context.read<LoanCubit>().saveLoanData(loan!);
                  Navigator.pushReplacementNamed(
                      context, Routes.creditHistoryPage);
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Cancel',
                isAppColor: false,
                onPressed: () => Navigator.of(context).pop(),
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
    ));
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
                  text: 'Result of your credit simulator',
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
                'We present to you in your amortization table the result of your credit movement.',
            fontWeight: FontWeight.w300,
            fontSize: 16),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
                text: 'Credit table',
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
            const SizedBox(height: 15),
            SimulatorTable(
              loan: state.loan!,
            ),
          ],
        );
      },
    );
  }
}
