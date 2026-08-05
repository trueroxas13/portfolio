import 'account-transaction.dart';
import 'account.dart';

class CurrentAccount extends Account{
  double overdraftLimit = 1000, overdraftFee = 500;
  late bool overdraftProtection;

  CurrentAccount(String accountNumber) : overdraftProtection = true, super(accountNumber: accountNumber);

  double withdraw(double amount) {
    if (amount < 0){
      print("withdrawal amount is invalid");
      return 0.0;
    }

    double withdrawAmount;
    if (!overdraftProtection){
      withdrawAmount = amount;
      balance = balance - amount > -1000 ? (balance - amount) : (balance - amount - overdraftFee);
      print("withdrew ${withdrawAmount}, new balance: ${balance}");
      transactions.add(new AccountTransaction(transactionType: "withdraw", amount: -withdrawAmount));   
      return withdrawAmount;
    }
    withdrawAmount = balance - amount >= 0 ? amount : 0;
    withdrawAmount == 0 ? print("cannot withdraw due to overdraft protection.") : print("withdrew ${withdrawAmount}");
    if (withdrawAmount > 0) {
      balance -= withdrawAmount;
      print("withdrew ${withdrawAmount}, new balance: ${balance}");
      transactions.add(new AccountTransaction(transactionType: "withdraw", amount: -withdrawAmount));
    }
    return withdrawAmount;
  }
}