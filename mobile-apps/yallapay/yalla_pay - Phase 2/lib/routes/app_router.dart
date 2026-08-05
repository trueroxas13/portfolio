import 'package:go_router/go_router.dart';
import 'package:yalla_pay/screens/add_customer_screen.dart';
import 'package:yalla_pay/screens/add_invoice_screen.dart';
import 'package:yalla_pay/screens/cheque_screen.dart';
import 'package:yalla_pay/screens/cheque_details_screen.dart';
import 'package:yalla_pay/screens/create_payment.dart';
import 'package:yalla_pay/screens/customer_screen.dart';
import 'package:yalla_pay/screens/dashbord_screen.dart';
import 'package:yalla_pay/screens/deposit_details_screen.dart';
import 'package:yalla_pay/screens/deposit_screen.dart';
import 'package:yalla_pay/screens/deposit_update_screen.dart';
import 'package:yalla_pay/screens/edit_customer_screen.dart';
import 'package:yalla_pay/screens/edit_invoice_screen.dart';
import 'package:yalla_pay/screens/invoice_screen.dart';
import 'package:yalla_pay/screens/login_screen.dart';
import 'package:yalla_pay/screens/payment_screen.dart';
import 'package:yalla_pay/screens/shell_screen.dart';

class AppRouter {  
  static const login = (name: 'login', path: '/');
  static const dashboard = (name: 'dashboard', path: '/dashboard');

  static const customer = (name: 'customers', path: '/customers'); 
  static const editCust = (name: 'edit-customer', path: '/customers/edit:id');
  static const newCust = (name: 'new-customer', path: '/customers/new');

  static const invoice = (name: 'invoices', path: '/invoices'); 
  static const editInvoice = (name: 'edit-invoice', path: '/invoices/edit:id');
  static const newInvoice = (name: 'new-invoice', path: '/invoices/new');

  static const payment = (name: 'payments', path: '/invoices/payments:id');
  static const newPayment = (name: 'payment', path: '/invoices/payments:id/new-payment:invoice');

  static const cheque = (name: 'cheques', path: '/cheques'); 
  static const chequeDetails = (name: 'cheque-details', path: '/cheques/details:id');

  static const deposit = (name: 'deposits', path: '/deposits'); 
  static const depositDetails = (name: 'deposits-details', path: '/deposits/details:id');
  static const depositUpdate = (name: 'deposits-update', path: '/deposits/update:id');



  static final router = GoRouter(
    initialLocation: login.path,
    routes: [
      ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
          GoRoute(
            name: login.name,
            path: login.path,
            builder: (context, state) => const LoginScreen(),
            routes: [
              GoRoute(
                name: dashboard.name,
                path: dashboard.path,
                builder: (context, state) => const DashbordScreen(),
                routes: [
                  GoRoute(
                    name: customer.name,
                    path: customer.path, 
                    builder: (context, state) => const CustomerScreen(),
                    routes: [
                      GoRoute(
                        name: newCust.name,
                        path: newCust.path,
                        builder: (context, state) => const AddCustomerScreen(),
                      ),
                      GoRoute(
                        name: editCust.name,
                        path: editCust.path,
                        builder: (context, state) {
                          String? id = state.pathParameters['id'];
                          return EditCustomerScreen(id: id!);
                        } ,
                      ),
                    ]
                  ),
                  GoRoute(
                    name: invoice.name,
                    path: invoice.path, 
                    builder: (context, state) => const InvoiceScreen(),
                    routes: [
                      GoRoute(
                        name: newInvoice.name,
                        path: newInvoice.path,
                        builder: (context, state) => const AddInvoiceScreen(),
                      ),
                      GoRoute(
                        name: editInvoice.name,
                        path: editInvoice.path,
                        builder: (context, state) {
                          String? id = state.pathParameters['id'];
                          return EditInvoiceScreen(id: id!);
                        } ,
                      ),
                      GoRoute(
                        name: payment.name,
                        path: payment.path,
                        builder: (context, state) {
                          String? id = state.pathParameters['id'];
                          return PaymentScreen(id: id!);
                        } ,
                        routes: [
                          GoRoute(
                            name: newPayment.name,
                            path: newPayment.path,
                            builder:(context, state) {
                              String? invoice = state.pathParameters['invoice'];
                              return CreatePaymentScreen(invoiceId: invoice!);
                            },
                          )
                        ]
                      ),
                    ]
                  ),
                  GoRoute(
                    name: cheque.name,
                    path: cheque.path, 
                    builder: (context, state) => const ChequeScreen(),
                    routes: [
                      GoRoute(
                        name: chequeDetails.name,
                        path: chequeDetails.path,
                        builder:(context, state) {
                          String? id = state.pathParameters['id'];
                          return CreateChequeDepositScreen(id: int.parse(id!));
                        },
                      )
                    ]
                  ),
                  GoRoute(
                    name: deposit.name,
                    path: deposit.path, 
                    builder: (context, state) => const DepositScreen(),
                    routes: [
                      GoRoute(
                        name: depositDetails.name,
                        path: depositDetails.path,
                        builder: (context, state) {
                          String? id = state.pathParameters['id'];
                          return DepositDetailsScreen(id: id!);
                        },
                      ),
                      GoRoute(
                        name: depositUpdate.name,
                        path: depositUpdate.path,
                        builder: (context, state) {
                          String? id = state.pathParameters['id'];
                          return DepositUpdateScreen(id: id!);
                        },
                      )
                    ]
                  ),
                ],
              ),
            ]
          ),
        ],
      )
  ]
);
}
