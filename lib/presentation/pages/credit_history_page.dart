import 'package:cw_bank_credit/presentation/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/loan_cubit.dart';
import '../../logic/states/loan_state.dart';
import '../widgets/utils/bottom_navigator_menu.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Historial de Créditos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: savedLoans.length,
                      itemBuilder: (context, index) {
                        final loan = savedLoans[index];
                        return ListTile(
                          title: Text(
                              'Monto del préstamo: ${loan.loanAmount.toStringAsFixed(2)}'),
                          subtitle: Text('Cuotas: ${loan.loanTerm.toString()}'),
                          // Agrega más detalles de la tabla aquí si es necesario
                        );
                      },
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
}
