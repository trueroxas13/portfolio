import 'package:flutter/material.dart';

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});

  TextStyle numStyle (Color color){
    return TextStyle(color: color, fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          // padding:  const EdgeInsets.only(top:100),
          // gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,),
          children:  [
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 15),
              child: Text('D A S H B O A R D', textAlign: TextAlign.center, style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 121, 121, 121)),),
            ),
            const Divider(),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('I N V O I C E S', style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 32
                ),),
                const Divider(indent: 20, endIndent: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('A L L : '),
                    Text('QR 99.99', style: numStyle(Colors.green))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('D U E  I N   30 D A Y S : '),
                    Text('QR 33.33', style: numStyle(Colors.blue))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('D U E  I N   60 D A Y S : '),
                    Text('QR 66.66', style: numStyle(Colors.red),)
                  ],
                ),
                const Divider(indent: 20, endIndent: 20,),
              ],
            ),
            const SizedBox(height: 150,),
            Column(
              children: [
                const Text('C H E Q U E S', style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 32
                ),),
                const Divider(indent: 20, endIndent: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('A W A I T I N G : '),
                    Text('QR 66.66', style: numStyle(const Color.fromARGB(255, 235, 199, 133)),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('D E P O S I T E D : '),
                    Text('QR 66.66', style: numStyle(Colors.blue),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('C A S H E D : '),
                    Text('QR 66.66', style: numStyle(Colors.green),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('R E T U R N E D : '),
                    Text('QR 66.66', style: numStyle(Colors.red),)
                  ],
                ),
                const Divider(indent: 20, endIndent: 20,),
              ],
              
            ),
          ],
        ),
      ),
    );
  }
}