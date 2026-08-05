import 'account-transaction.dart';

mixin TransactionLogger{
  List<AccountTransaction> loggerHistory = [];
  
  logTransaction(AccountTransaction transaction) {
    loggerHistory.add(transaction);
  }
  String printTransactionLog() {
    return "Transactions:\n${loggerHistory}";
  }
}