import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wanderlist/model/destination.dart';
import 'package:wanderlist/providers/destination_provider.dart';
import 'package:wanderlist/routes/app_routes.dart';

class DestinationsListScreen extends ConsumerStatefulWidget {
  const DestinationsListScreen({super.key});

  @override
  ConsumerState<DestinationsListScreen> createState() => _DestinationsListScreenState();
}

class _DestinationsListScreenState extends ConsumerState<DestinationsListScreen> {
  List<Destination> destinations = [];
  final DateFormat format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    destinations = ref.watch(destinationNotifierProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 240, mainAxisSpacing: 5, crossAxisSpacing: 5),
          
          children: List.generate(destinations.length, (index){
            return GestureDetector(
              onTap: (){
                context.pushNamed(AppRouter.destinationDetails.name, pathParameters: {'id' : destinations[index].id});
              },
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 370,
                      child: Image.asset('assets/images/${destinations[index].image}',
                              fit: BoxFit.fitWidth,)),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                            destinations[index].location
                          ),
                        )
                    ],),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            destinations[index].country
                          ),
                          Text(
                            format.format(destinations[index].visitDate), style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Edit', style: TextStyle(color: Colors.blue),),
                        IconButton(onPressed: (){
                          context.pushNamed(AppRouter.editDestination.name, pathParameters: {'id' : destinations[index].id});
                        }, icon: const Icon(Icons.edit), color: Colors.blue,),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
