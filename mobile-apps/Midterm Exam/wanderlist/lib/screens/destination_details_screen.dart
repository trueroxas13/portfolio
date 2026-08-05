import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wanderlist/model/destination.dart';
import 'package:wanderlist/providers/destination_provider.dart';

class DestinationDetailsScreen extends ConsumerStatefulWidget {
  final String thisId;
  const DestinationDetailsScreen({required this.thisId, super.key});

  @override
  ConsumerState<DestinationDetailsScreen> createState() => _DestinationDetailsScreenState();
}

class _DestinationDetailsScreenState extends ConsumerState<DestinationDetailsScreen> {
  final DateFormat format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    final Destination destination = ref.watch(destinationNotifierProvider.notifier).getDestinationById(widget.thisId);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: Text(
            destination.location,
            style: const TextStyle(
              fontSize: 25
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset('assets/images/${destination.image}', fit: BoxFit.fitWidth),
            ),
            const SizedBox(height: 10,),
            Text(destination.location, style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Text(destination.country, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5,),
            Text('V I S I T    D A T E :  ${format.format(destination.visitDate)}',
            ),
            const SizedBox(height: 10,),
            Text('S T A T U S :   ${destination.status}',
            style: TextStyle(color: destination.status == 'Visited' ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 20,),
            const Text('D E S C R I P T I O N', style: TextStyle(fontWeight: FontWeight.bold),),
            Text(destination.description),
          ],
        ),
      ),
    );
  }
}