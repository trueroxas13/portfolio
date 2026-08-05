import 'account.dart';

class Customer {
  late String name;
  late int age;
  List<Account> accounts = [];

  addAccount(Account account){
    accounts.add(account);
  }

  double getTotalBalance(){
    double bal = 0;
    accounts.forEach((a) => bal += a.balance);
    return bal;
  }

  String getDetails(){
    return "\n\nname: $name, age: ${age}\naccounts: ${accounts}";
  }

  Customer({required this.name, required this.age});
}