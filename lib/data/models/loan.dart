import 'dart:math';

class Loan {
  double loanAmount;
  double baseSalary;
  int loanTerm;
  double creditRate;
  Loan({
    required this.loanAmount,
    required this.creditRate,
    required this.baseSalary,
    required this.loanTerm,
  });

  double calculateInstallment() {
    return (loanAmount * creditRate) / (1 - pow(1 + creditRate, -loanTerm));
  }
}
