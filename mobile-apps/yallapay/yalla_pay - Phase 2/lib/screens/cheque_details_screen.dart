import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yalla_pay/model/bank_account.dart';
import 'package:yalla_pay/model/cheque.dart';
import 'package:yalla_pay/providers/cheque_provider.dart';
import 'package:yalla_pay/widgets/styles_details.dart';

class CreateChequeDepositScreen extends ConsumerStatefulWidget {
  final int id;
  const CreateChequeDepositScreen({super.key, required this.id});


  @override
  ConsumerState<CreateChequeDepositScreen> createState() => _CreateChequeDepositScreenState();
}

class _CreateChequeDepositScreenState extends ConsumerState<CreateChequeDepositScreen> {

  StylesDetails stylesDetails = StylesDetails();

  final DateFormat format = DateFormat("yyyy-MM-dd");
  
  List<BankAccount> accounts = [];
  List<Cheque> cheques = [];
  int selection = -1;
  @override
  Widget build(BuildContext context) {
    cheques = ref.watch(chequeNotifierProvider);

    Cheque cheque = cheques.firstWhere((c) => c.chequeNo == widget.id);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            const Text('C H E Q U E\nD E T A I L S', 
            textAlign: TextAlign.center, 
            style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 121, 121, 121)),
            ),
            const Divider(),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...stylesDetails.chequeHeadingDetailEntry(heading: 'ChequeNo', detail: '${cheque.chequeNo}', icon: const Icon(Icons.numbers, color: Colors.grey,)),
                      ...stylesDetails.chequeHeadingDetailEntry(heading: 'Drawer', detail: cheque.drawer, icon: const Icon(Icons.person_outline, color: Colors.grey,)),
                      ...stylesDetails.chequeHeadingDetailEntryWithBorder(
                        heading: 'Status', 
                        detail: cheque.status, 
                        icon: const Icon(Icons.check_circle_outline, color: Colors.grey,),
                        backgroundColor: const Color.fromARGB(255, 211, 235, 255),
                        textColor: const Color.fromARGB(255, 109, 129, 219)
                        ),
                      ...stylesDetails.chequeHeadingDetailEntry(heading: 'Due Date', detail: format.format(cheque.dueDate), icon: const Icon(Icons.calendar_month_outlined, color: Colors.grey,)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...stylesDetails.chequeHeadingDetailEntry(heading: 'Amount', detail: '${cheque.amount}', icon: const Icon(Icons.monetization_on_outlined, color: Colors.grey,)),
                      ...stylesDetails.chequeHeadingDetailEntryWithBorder(
                        heading: 'Drawer Bank', 
                        detail: cheque.bankName, 
                        icon: const Icon(Icons.account_balance_outlined, color: Colors.grey,),
                        backgroundColor: Colors.blue[900],
                        textColor: Colors.white,
                        ),
                      ...stylesDetails.chequeHeadingDetailEntry(heading: 'Received Date', detail: format.format(cheque.receivedDate), icon: const Icon(Icons.calendar_month_outlined, color: Colors.grey,)),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Icon(Icons.image, color: Colors.grey,),
                          Text('  Cheque Image', style: stylesDetails.headingStyle(const Color.fromARGB(255, 122, 122, 122)),),
                        ],
                        ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 20,
                        child: Image.asset('assets/images/${cheque.chequeImageUri}')),
                      const SizedBox(height: 30,),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}