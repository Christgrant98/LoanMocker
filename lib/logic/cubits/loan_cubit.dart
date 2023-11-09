import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/loan.dart';
import '../states/loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanState.initial());

  Future<void> setLoan(Loan loan) async {
    return emit(
      state.copyWith(loan: loan),
    );
  }

  Future<void> saveLoanData(Loan loan) async {
    final updatedSavedLoans = [...state.loansData, loan];
    return emit(state.copyWith(loansData: updatedSavedLoans));
  }

  Loan? getCurrentLoan() {
    return state.loan;
  }
}
