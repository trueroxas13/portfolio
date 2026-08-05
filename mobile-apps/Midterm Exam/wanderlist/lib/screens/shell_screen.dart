import 'package:flutter/material.dart';

class ShellScreen extends StatefulWidget {
  final Widget? child;
  const ShellScreen({this.child, super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 93, 104),
        title: const Center(
          child: Text('W A N D E R   L I S T', style: TextStyle(color: Colors.white),)),
      ),
      body: widget.child,
    );
  }
}
