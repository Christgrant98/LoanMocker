import '../../data/models/loan.dart';

class LoanState {
  final Loan? loan;

  LoanState({
    required this.loan,
  });

  factory LoanState.initial() {
    return LoanState(
      loan: null,
    );
  }

  LoanState copyWith({
    Loan? loan,
    String? error,
  }) {
    return LoanState(
      loan: loan ?? this.loan,
    );
  }
}
