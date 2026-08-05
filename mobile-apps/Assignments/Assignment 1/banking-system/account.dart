import 'account-transaction.dart';

class Account {
  late String accountNumber;
  late double balance;
  List<AccountTransaction> transactions = [];

  Account({required this.accountNumber}) : balance = 0;
  
  deposit(double amount){
    double depositAmount = amount >= 0 ? amount : 0;
    balance += depositAmount;
    if (depositAmount > 0){
      print("deposited ${depositAmount}, new balance: ${balance}");
      transactions.add(new AccountTransaction(transactionType: "deposit", amount: depositAmount));
    } else {
      print("deposit amount is invalid");
    }
  }

  double withdraw (double amount){
    
    if (amount < 0) {
      print("withdrawal amount is invalid");
      return 0.0;
    }
    double withdrawAmount = amount > balance ? 0 : amount;
    balance -= withdrawAmount;
    if (withdrawAmount != 0){
      print("withdrew ${withdrawAmount}, new balance: ${balance}");
      transactions.add(new AccountTransaction(transactionType: "withdraw", amount: -withdrawAmount));
      return withdrawAmount;
    }
    print("withdrawal amount exceeds account balance");
    return withdrawAmount;
  }

  String toString(){
    return "\naccount number: $accountNumber, balance: ${balance}, \ntransactions: ${transactions}\n";
  }

}