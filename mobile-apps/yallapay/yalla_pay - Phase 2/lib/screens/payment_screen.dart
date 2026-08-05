import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_pay/model/cheque.dart';
import 'package:yalla_pay/model/payment.dart';
import 'package:yalla_pay/providers/cheque_provider.dart';
import 'package:yalla_pay/providers/payment_provider.dart';
import 'package:yalla_pay/providers/update_provider.dart';
import 'package:yalla_pay/routes/app_router.dart';


class PaymentScreen extends ConsumerStatefulWidget {
  final String id;
  const PaymentScreen({super.key, required this.id});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  
  TextStyle labelsStyle (){
    return TextStyle(fontSize: 20, color: Colors.blueGrey[700], fontWeight: FontWeight.bold);
  }

  String searchText = '';
  var filteredPayments = [];
  var payments = [];
  List<Cheque> cheques = [];
  bool hasLoaded = false;
  @override
  Widget build(BuildContext context) {

    var allPayments = ref.watch(paymentNotifierProvider);
    
    cheques = ref.watch(chequeNotifierProvider);

    if (allPayments.isNotEmpty){
      payments = allPayments.where((element) => element.invoiceNo == widget.id,).toList();
    }

    if (payments.isNotEmpty && !hasLoaded){
     filteredPayments = payments;
     hasLoaded = true; 
    }

    if (ref.watch(updateNotifierProvider)){
      filteredPayments = payments;
    }

    if (searchText.isNotEmpty){
      filteredPayments = ref.read(paymentNotifierProvider.notifier).searchPaymentsByModeAndID(widget.id, searchText);
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 15),
            child: Text('P A Y M E N T S', textAlign: TextAlign.center, style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 121, 121, 121)),),
          ),
          const Divider(),
          SizedBox(
            width: 400,
            child: TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'S E A R C H'
              ),
              onChanged: (value){
                setState(() {
                  if (value.length < searchText.length){
                    filteredPayments = payments;
                  }
                  searchText = value;
                  filteredPayments = ref.read(paymentNotifierProvider.notifier)
                    .searchPaymentsByModeAndID(widget.id, searchText);
                });
              },
            )
          ),
          Expanded(
            child: filteredPayments.isEmpty ?
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt, size: 300, color: Color.fromARGB(255, 197, 197, 197),),
                  Text('Looks like there are no payments, add some!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 197, 197), fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 200,)
                ],
              )
              : ListView.builder(
              itemCount: filteredPayments.length,
              itemBuilder: (context, index) { 
                Payment payment = filteredPayments[index]; 
                Icon? icon;
                switch (payment.paymentMode){
                  case "Cheque" : 
                    icon = const Icon(Icons.receipt, color: Color.fromARGB(255, 76, 100, 151),);
                  case "Bank transfer" : 
                    icon = const Icon(Icons.account_balance_outlined, color: Color.fromARGB(255, 76, 100, 151),);
                  case "Credit card" : 
                    icon = const Icon(Icons.credit_card, color: Color.fromARGB(255, 76, 100, 151),);
                }
                  return Padding(
                    padding: const EdgeInsets.only(left:16.0, right:16.0, bottom: 8.0),
                    child: Card(
                      color: index % 2 == 0 ? const Color.fromARGB(255, 231, 233, 255) : const Color.fromARGB(255, 208, 212, 252),
                      child: ListTile(
                        leading: icon,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              payment.paymentMode,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'QR ${payment.amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              payment.paymentDate,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 73, 54, 95),
                              ),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed: (){
                                switch(payment.paymentMode){
                                  case "Cheque":
                                    context.pushNamed(AppRouter.chequeDetails.name);
                                  case "Bank transfer":
                                    
                                  case "Credit card":
                                  
                                }
                                
                              }, 
                              icon: Icon(Icons.edit, color: Colors.blue[800],)),
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    ref.read(paymentNotifierProvider.notifier).deletePayment(payment.id!);
                                    filteredPayments = ref.read(paymentNotifierProvider.notifier).searchPaymentsByInvoice(widget.id);
                                  });
                                }, 
                                icon: const Icon(Icons.delete, color: Colors.red)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
