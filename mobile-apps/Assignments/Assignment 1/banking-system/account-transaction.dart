class AccountTransaction {
  late String transactionType;
  late double amount;

  AccountTransaction({required this.transactionType, required this.amount});

  String toString(){
    return "\ntransaction type: $transactionType, amount: ${amount}";
  }
}