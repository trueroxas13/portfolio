import 'customer.dart';
import 'current-account.dart';
import 'saving-account.dart';

void main (List<String> Args){
  var c1 = new Customer(name: "john", age: 31);
  
  var c2 = new Customer(name: "doe", age: 23);

  //for testing purposes, c1 will have 1 saving account, c2 will have 1 of each

  c1.addAccount(new SavingAccount("12405971457"));

  c2.addAccount(new SavingAccount("91324795034"));
  c2.addAccount(new CurrentAccount("319764593156"));

  //also for testing purposes, all fields have been implemented as public for easier access
  //depositing and withdrawing from accounts

  print("depositing \$40000 in c1's savings account:");
  c1.accounts[0].deposit(40000);

  print("depositing \$45000 in c2's savings account:");
  c2.accounts[0].deposit(45000);
  print("depositing \$3000 in c2's current account:");
  c2.accounts[1].deposit(3000);

  //cannot deposit negative numbers
  print("attempting to deposit \$-1284681426 in c1's saving account");
  c1.accounts[0].deposit(-1284681426);

  //for withdrawing, will check for savings/current type

  if (c1.accounts[0] is SavingAccount){
    //since a savings account has no special implementation, will call the default method
    print("withdrawing \$3000 from c1's saving account:");
    c1.accounts[0].withdraw(3000);
    //since this is a savings account, cannot withdraw more than saved balance
    print("attempting to withdraw \$1324791476556 from c1's saving account:");
    c1.accounts[0].withdraw(1324791476556);
    //cannot withdraw negative numbers
    print("attempting to withdraw \$-214864 from c1's saving account:");
    c1.accounts[0].withdraw(-214864);
  }

  if (c2.accounts[1] is CurrentAccount){
    //withdrawing to check if overdraft protection works
    CurrentAccount tempAcc1 = c2.accounts[1] as CurrentAccount;
    print("attempting to withdraw \$3750 from c2's current account balance with overdraft protection enabled:");
    tempAcc1.withdraw(3750); 
    //now disabling protection and withdrawing
    print("now with protection disabled:");
    tempAcc1.overdraftProtection = false;
    tempAcc1.withdraw(3750); 
    c2.accounts[1] = tempAcc1;
  }

  //trying to add and apply investment profit for c2's savings account...
  //will also check taxing
  if (c2.accounts[0] is SavingAccount){
    SavingAccount tempAcc2 = c2.accounts[0] as SavingAccount;
    print("the bank generates profit for c1 of \$20000");
    tempAcc2.calculateProfit(20000);
    tempAcc2.applyTax();
    tempAcc2.applyProfit();
    c2.accounts[0] = tempAcc2;

    //using tempAcc2 (for convenience) to read the profit logs
    print("checking c2's savings mixin transaction history:");
    print (tempAcc2.printTransactionLog());
  }

  //now to check the details
  print("\n\nc1's details:\n${c1.getDetails()}\n\n\n");
  print("c2's details:\n${c2.getDetails()}");

  //checking their total balances
  print("c1's total balance: ${c1.getTotalBalance()}\nc2's total balance: ${c2.getTotalBalance()}");
}