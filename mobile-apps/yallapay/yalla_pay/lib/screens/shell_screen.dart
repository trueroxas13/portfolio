import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_pay/providers/login_provider.dart';
import 'package:yalla_pay/routes/app_router.dart';
import 'package:yalla_pay/screens/add_customer_screen.dart';
import 'package:yalla_pay/screens/create_payment.dart';
import 'package:yalla_pay/screens/edit_customer_screen.dart';
import 'package:yalla_pay/screens/edit_invoice_screen.dart';
import 'package:yalla_pay/screens/invoice_screen.dart';
import 'package:yalla_pay/screens/payment_screen.dart';


class ShellScreen extends ConsumerStatefulWidget {
  final Widget? child;
  const ShellScreen({super.key, this.child});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
     bool login = ref.read(loginNotifierProvider);
    return Scaffold(
      body: widget.child,
       bottomNavigationBar: login ? BottomNavigationBar(
         backgroundColor: Colors.white,
         // set the current index
         currentIndex: selectedIndex,
         selectedItemColor: Colors.purple[700], // Color for selected item
         unselectedItemColor: Colors.grey, // Color for unselected items
        // make it active when selected
         onTap: (value){
           setState(() {
           switch(value){
             case 0:
               selectedIndex = value;
               context.goNamed(AppRouter.dashboard.name);
             case 1:
               selectedIndex = value;
               context.goNamed(AppRouter.customer.name);
             case 2:
               selectedIndex = value;
               context.goNamed(AppRouter.invoice.name);
             case 3:
               selectedIndex = value;
               context.goNamed(AppRouter.cheque.name);
             case 4:
               selectedIndex = value;
               context.goNamed(AppRouter.deposit.name);
           }
         });
         },
         items: const [
           BottomNavigationBarItem(
             icon: Icon(Icons.dashboard),
             label: 'Dashbord',
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.person),
             label: 'Customers',
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.money),
             label: 'Invoices',
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.monetization_on_outlined),
             label: 'Cheques',
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.wallet),
             label: 'Cheque Deposits',
           )
         ],
       ) : const SizedBox(height: 1),

      floatingActionButton: 
       switch(selectedIndex){
        0 =>
          Container(),
        1 =>
          (widget.child is! AddCustomerScreen && widget.child is! EditCustomerScreen) ? 
          FloatingActionButton(
            onPressed: (){
              setState(() {
                context.pushNamed(AppRouter.newCust.name);
              });
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white, size: 40,),
          ) : Container(),
        2 => 
          (widget.child is! CreatePaymentScreen && widget.child is! EditInvoiceScreen) ? 
          FloatingActionButton(
            onPressed: (){
              setState(() {
                if (widget.child is InvoiceScreen){
                context.pushNamed(AppRouter.newInvoice.name);
                }
                if (widget.child is PaymentScreen){
                context.pushNamed(AppRouter.newPayment.name);
                }
              });
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white, size: 40,),
          ) : Container(),
        3 =>
          Container(),
        4 =>
          Container(),
        int() => throw UnimplementedError(),
      } ,
    );
  }
}
