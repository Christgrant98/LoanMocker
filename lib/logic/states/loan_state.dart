import '../../data/models/loan.dart';

class LoanState {
  final Loan? loan;
  final List<Loan> loansData;

  LoanState({
    required this.loansData,
    required this.loan,
  });

  factory LoanState.initial() {
    return LoanState(
      loan: null,
      loansData: [],
    );
  }

  LoanState copyWith({
    Loan? loan,
    String? error,
    List<Loan>? loansData,
  }) {
    return LoanState(
      loansData: loansData ?? this.loansData,
      loan: loan ?? this.loan,
    );
  }
}
