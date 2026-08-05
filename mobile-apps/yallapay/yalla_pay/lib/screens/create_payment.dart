import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalla_pay/providers/payment_mode_provider.dart';
import 'package:yalla_pay/widgets/styles_details.dart';

class CreatePaymentScreen extends ConsumerStatefulWidget {
  final String invoiceId;
  const CreatePaymentScreen({super.key, required this.invoiceId});

  @override
  ConsumerState<CreatePaymentScreen> createState() => _CreatePaymentState();
}

class _CreatePaymentState extends ConsumerState<CreatePaymentScreen> {
  bool validCreation = false;
  final StylesDetails stylesDetails = StylesDetails();

  List<String> modes = [];
  String? currentOption, amount;

  @override
  Widget build(BuildContext context) {

    modes = ref.watch(paymentModeNotifierProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            const Text('C R E A T E\nP A Y M E N T', 
            textAlign: TextAlign.center, 
            style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 121, 121, 121)),
            ),
            const Divider(),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.monetization_on_outlined, color: Colors.grey,),
                        Text('  Payment Method   ', style: stylesDetails.headingStyle(const Color.fromARGB(255, 122, 122, 122)),),
                      ],
                      ),
                      const SizedBox(height: 10,),
                      ...List.generate(modes.length, (index){
                        return Row(
                            children: [
                              Radio(
                              value: modes[index],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                              Text(modes[index], style: stylesDetails.detailStyle(const Color.fromARGB(255, 122, 122, 122)),),
                            ],
                          ); 
                      })]
                    ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:32.0),
                  child: 
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_month_outlined, color: Colors.grey,),
                          Text('  Amount   ', style: stylesDetails.headingStyle(const Color.fromARGB(255, 122, 122, 122)),),
                        ],
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width:175,
                        child: TextField(
                          decoration: const InputDecoration(
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)
                            )
                          ),
                          onChanged: (value){
                            amount = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 90,),
                      
                    ],
                  ),
                ),
            ],),
                const Divider(),
                currentOption == "Cheque" ?
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on_outlined, color: Colors.grey,),
                  Text('  Cheques   ', style: stylesDetails.headingStyle(const Color.fromARGB(255, 122, 122, 122)),),
                ],
                ) : Container(),
                currentOption == "Cheque" ?
                const SizedBox(height: 10,): const SizedBox(height: 248,),
                currentOption == "Cheque" ?
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left:16.0, right:16.0),
                    
                  ),
                ) : Container(),
                ElevatedButton(
              onPressed: (){
                setState(() {
                 
                });
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: validCreation ? const Color.fromARGB(255, 216, 238, 253) : const Color.fromARGB(255, 218, 218, 218),
                elevation: validCreation ? 5 : 0,
              ),
              child: Text('  C R E A T E  ', 
              style: TextStyle(
                fontSize: 25, 
                color: validCreation ? const Color.fromARGB(255, 98, 123, 204) : Colors.black, 
                fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}