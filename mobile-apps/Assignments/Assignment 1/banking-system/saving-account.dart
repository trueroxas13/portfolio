import 'account-transaction.dart';
import 'account.dart';
import 'taxable.dart';
import 'transaction-logger.dart';

class SavingAccount extends Account with TransactionLogger implements Taxable {
  //profit sharing is 70% holder, 30% account
  late double investmentProfit;
  double profitSharingRatio = 0.7; //70% of the profit goes to the holder 

  SavingAccount(String accountNumber) : super(accountNumber: accountNumber);

  applyProfit() {
    balance += investmentProfit;
    print("profit applied, new balance: ${balance}");
    logTransaction(new AccountTransaction(transactionType: "investment-profit", amount: investmentProfit));
  }

  calculateProfit(double totalProfit) {
    double profit = totalProfit > 0 ? totalProfit : 0;
    if (profit != 0){
      investmentProfit = totalProfit*profitSharingRatio;
      print("investment profit is ${investmentProfit}");
    } else {
      print("invalid total profit provided");
    }
  }

  @override
  applyTax() {
    investmentProfit = investmentProfit*0.95;
    print("after applying a 5% tax in the profit: ${investmentProfit}");
  }
}