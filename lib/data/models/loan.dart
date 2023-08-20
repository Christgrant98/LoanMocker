class Loan {
  int? loanAmount;
  int? baseSalary;
  int? loanTerm;
  Map<String, double> creditRates = {
    'Crédito de vehiculo': 0.03,
    'Crédito de vivienda': 0.01,
    'Crédito de libre inversión': 0.035,
  };
  Loan({
    this.loanAmount,
    required this.creditRates,
    this.baseSalary,
    this.loanTerm,
  });
}
