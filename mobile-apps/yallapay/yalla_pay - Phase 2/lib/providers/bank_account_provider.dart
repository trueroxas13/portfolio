import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalla_pay/model/bank_account.dart';
import 'package:yalla_pay/providers/streamvault_repo_provider.dart';
import 'package:yalla_pay/repo/streamvault_repository.dart';

class BankAccountNotifier extends Notifier<List<BankAccount>> {
  late final StreamVaultRepository _repository;
   @override
   List<BankAccount> build() {
  //   _repository = await ref.watch(streamVaultRepoProvider.future);
  //      _repository.observeBankAccount().listen((bankAccount) {
  //     state = AsyncData(bankAccount);
  //   });
   return [];
   }


  void deleteBankAccount(BankAccount bankAccount) async{
    await _repository.deleteBankAccount(bankAccount);
  }

  void addBankAccount(BankAccount bankAccount) async {
    await _repository.addBankAccount(bankAccount);
  }

  void updateBankAccount(BankAccount bankAccount) async {
    await _repository.updateBankAccount(bankAccount);
  }

}

final bankAccountNotifierProvider =
    NotifierProvider<BankAccountNotifier, List<BankAccount>>(() => BankAccountNotifier());