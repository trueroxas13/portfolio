import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalla_pay/model/cheque.dart';

class ChequeNotifier extends Notifier<List<Cheque>> {
  @override
  List<Cheque> build() {
    initializeCheques();
    return [];
  }

  void initializeCheques() async {
    String data = await rootBundle.loadString('assets/data/cheques.json');
    var chequesMap = jsonDecode(data) as List;
    List<Cheque> cheques = chequesMap.map((map) => Cheque.fromJson(map)).toList();
    state = cheques;
  }

  void addCheque(Cheque cheque) {
    state = [...state, cheque];
  }

  void deleteCheque(int chequeNo){
    state = state.where((c) => c.chequeNo != chequeNo).toList();
  }

  void updateChequeStatus(int chequeNo, String status){
    Cheque cheque = state.firstWhere((c) => c.chequeNo == chequeNo);

    cheque.status = status;

    for (var c in state){
      if (c.chequeNo == chequeNo){
        state[state.indexOf(c)] = cheque;
      }
    }

    var temp = state;
    state = [];
    state = temp;
  }

  void updateChequeReturnReason(int chequeNo, String reason){
    Cheque cheque = state.firstWhere((c) => c.chequeNo == chequeNo);

    cheque.returnReason = reason;

    for (var c in state){
      if (c.chequeNo == chequeNo){
        state[state.indexOf(c)] = cheque;
      }
    }

    var temp = state;
    state = [];
    state = temp;
  }

  void updateChequeCashedDate(int chequeNo, DateTime date){
    Cheque cheque = state.firstWhere((c) => c.chequeNo == chequeNo);

    cheque.cashedDate = date;

    for (var c in state){
      if (c.chequeNo == chequeNo){
        state[state.indexOf(c)] = cheque;
      }
    }

    var temp = state;
    state = [];
    state = temp;
  }

  // Example: Search for cheques by bank name
  List<Cheque> searchChequesByBank(String bankName) {
    return state
        .where((cheque) =>
            cheque.bankName.toLowerCase().contains(bankName.toLowerCase()))
        .toList();
  }

  // Example: Filter cheques by status
  List<Cheque> filterChequesByStatus(String status) {
    return state.where((cheque) => cheque.status == status).toList();
  }
}

final chequeNotifierProvider =
    NotifierProvider<ChequeNotifier, List<Cheque>>(() => ChequeNotifier());
