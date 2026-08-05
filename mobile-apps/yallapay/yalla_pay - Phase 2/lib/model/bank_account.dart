import 'dart:io';
import 'package:floor/floor.dart';

@Entity(tableName: 'bankaccounts')
class BankAccount {
  String accountNo;
  String bank;


  BankAccount({
  required this.accountNo,
  required this.bank,
  });

  factory BankAccount.fromJson(Map<String, dynamic> map) {
    return BankAccount(
      accountNo: map['accountNo'],
      bank: map['bank'],
    );
  }
}