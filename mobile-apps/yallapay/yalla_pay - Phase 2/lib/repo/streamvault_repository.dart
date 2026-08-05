import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yalla_pay/database/address_dao.dart';
import 'package:yalla_pay/database/bank_account_dao.dart';
import 'package:yalla_pay/database/user_dao.dart';
import 'package:yalla_pay/model/address.dart';
import 'package:yalla_pay/model/bank_account.dart';
import 'package:yalla_pay/model/user.dart';


class StreamVaultRepository implements BankAccountDao, UserDao, AddressDao{
  final BankAccountDao bankAccountDao;
  final UserDao userDao;
  final AddressDao addressDao;

  StreamVaultRepository({required this.bankAccountDao, required this.userDao, required this.addressDao});


  void initializeDatabase() async {

    //Read The BankAccounts 
    String dataBank = await rootBundle.loadString('assets/data/bank-accounts.json');
    var bankAccountsMap = jsonDecode(dataBank);
    for (var bankAccountMap in bankAccountsMap) {
      bankAccountDao.addBankAccount(BankAccount.fromJson(bankAccountMap));
    }

  //Read The Users
    String dataUser = await rootBundle.loadString('assets/data/users.json');
    var usersMap = jsonDecode(dataUser);
    usersMap.forEach((map) => userDao.addUser(User.fromJson(map)));

  


}
//Address
  @override
  Future<void> addAddress(Address address) => addressDao.addAddress(address);
   @override
  Future<void> deleteAddress(Address address) => addressDao.deleteAddress(address);
  @override
  Future<void> updateAddress(Address address) => addressDao.updateAddress(address);
  @override
  Stream<List<Address>> observeAddress() => addressDao.observeAddress();



  //User
  @override
  Stream<List<User>> observeUser() => userDao.observeUser();
  @override
  Future<void> addUser(User user) => userDao.addUser(user);
  @override
  Future<void> deleteUser(User user) => userDao.deleteUser(user);
  @override
  Future<void> updateUser(User user) => userDao.updateUser(user);



//BankAccount
  @override
  Future<void> deleteBankAccount(BankAccount bankAccount) => bankAccountDao.deleteBankAccount(bankAccount);
  @override
  Stream<BankAccount?> getBankAccount(String accountNo) => bankAccountDao.getBankAccount(accountNo);
  @override
  Stream<List<BankAccount>> observeBankAccount() => bankAccountDao.observeBankAccount();
  @override
  Future<void> addBankAccount(BankAccount bankAccount) => bankAccountDao.addBankAccount(bankAccount);
  @override
  Future<void> updateBankAccount(BankAccount bankAccount) => bankAccountDao.updateBankAccount(bankAccount);



}
