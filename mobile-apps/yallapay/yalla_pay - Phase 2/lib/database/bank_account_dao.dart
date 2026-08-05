import 'package:floor/floor.dart';
import 'package:yalla_pay/model/bank_account.dart';

@dao
 abstract class BankAccountDao {
  @Query('SELECT * FROM bankaccounts')
  Stream<List<BankAccount>> observeBankAccount();

  @insert
  Future<void> addBankAccount(BankAccount bankAccount);

  @delete
  Future<void> deleteBankAccount(BankAccount bankAccount);

  @update
  Future<void> updateBankAccount(BankAccount bankAccount);

  @Query('SELECT * FROM bankaccounts WHERE accountNo = :accountNo')
  Stream<BankAccount?> getBankAccount(String accountNo);
}