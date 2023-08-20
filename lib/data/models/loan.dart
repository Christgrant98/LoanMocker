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

  // (Monto del préstamo*Interés) /(1-(1+interés) ^ número de cuotas)
  double calculateInstallment() {
    return (loanAmount * creditRate) / (1 - pow(1 + creditRate, -loanTerm));
  }

  // TEA = (1 + Tasa de Interés Mensual) ^ 12 - 1
  double calculateTEA() {
    double tea = (pow(1 + creditRate, 12) - 1);
    return (tea * 100);
  }

  // (Monto del préstamo*Interés) /(1-(1+interés) ^ número de cuotas) * loanTerm
  double calculateTotalLoan() {
    return calculateInstallment() * loanTerm;
  }
}
