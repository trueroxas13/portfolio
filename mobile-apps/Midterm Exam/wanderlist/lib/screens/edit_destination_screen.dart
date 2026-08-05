import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wanderlist/model/destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderlist/providers/countries_provider.dart';
import 'package:wanderlist/providers/destination_provider.dart';

class EditDestinationScreen extends ConsumerStatefulWidget {
  final String destinationId;

  const EditDestinationScreen({super.key, required this.destinationId});

  @override
  ConsumerState<EditDestinationScreen> createState() =>
      _EditDestinationFormState();
}

class _EditDestinationFormState extends ConsumerState<EditDestinationScreen> {
  bool isLoaded = false;

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _visitDateController = TextEditingController();
  final DateFormat format = DateFormat("yyyy-MM-dd");


  String _selectedStatus = 'Not Yet';
  String? _selectedCountry; // Track the selected country
  final List<String> _statuses = ['Visited', 'Not Yet'];

  @override
  Widget build(BuildContext context) {
    final Destination destination = ref.watch(destinationNotifierProvider.notifier).getDestinationById(widget.destinationId);
    var countries = ref.watch(countriesNotifierProvider);
    
    if (!isLoaded){
      _locationController.text = destination.location;
      _descriptionController.text = destination.description;
      _imageController.text = destination.image;
      _visitDateController.text = format.format(destination.visitDate);
      _selectedStatus = destination.status;
      _selectedCountry = destination.country;

      isLoaded = true;
    }
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Center(
          child: Text('E D I T    D E S T I N A T I O N',
            style: TextStyle(
              fontSize: 25
            )),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset('assets/images/${destination.image}', fit: BoxFit.fitWidth),
              ),
            const SizedBox(height: 10,),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Location Name'),
              ),
              style: const TextStyle(
                fontSize: 13
              ),
              onChanged: (value) {
                setState(() {
                  _locationController.text = value;
                });
              },
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Description'),
              ),
              onChanged: (value) {
                setState(() {
                  _descriptionController.text = value;
                });
              },
              style: const TextStyle(
                fontSize: 13
              ),
              minLines: 1,
              maxLines: 5
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Image File Name'),
              ),
              style: const TextStyle(
                fontSize: 13
              ),
              onChanged: (value) {
                setState(() {
                  _imageController.text = value;
                });
              },
            ),
            const SizedBox(height: 15,),

            Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 91, 168, 168),
              border: Border.all(
                width: 5,
                color: const Color.fromARGB(255, 91, 168, 168),
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            width: double.infinity,
            height: 50,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: _selectedCountry,
                  hint: const Text('C O U N T R Y'),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black
                  ),
                  isExpanded: true,
                  padding: const EdgeInsets.all(8.0),
                  menuMaxHeight: 200,
                  items: countries.map((e) {
                    return DropdownMenuItem<String>(value: e.name,child: Text(e.name),);
                  },).toList(), 
                  onChanged: (String? value) 
                  { 
                    setState(() {
                      _selectedCountry = value!;
                    });
                  }, 
              ),),
            ),
          ),

            const SizedBox(height: 20,),
            
            SizedBox(
                width:double.infinity,
                child: TextField(
                  controller: _visitDateController,
                  decoration: const InputDecoration(
                    labelText: 'VISIT   DATE',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                    )
                  ),
                  style: const TextStyle(
                    fontSize: 13
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                ),
              ),
            
            const SizedBox(height: 15,),

            Row(
              children: [
                const Text('S T A T U S'),
                const SizedBox(width: 30,),
                ...List.generate(_statuses.length, (index){
                  return Row(
                    children: [
                      Radio(
                      value: _statuses[index],
                      groupValue: _selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value.toString();
                        });
                      },
                    ),
                      Text(_statuses[index]),
                    ],
                  ); 
                })
              ],
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(onPressed: (){
                setState(() {
                  Destination update = Destination(
                    id: destination.id,
                    location: _locationController.text,
                    description:  _descriptionController.text,
                    image: _imageController.text,
                    status: _selectedStatus,
                    country: _selectedCountry!,
                    visitDate: DateTime.parse(_visitDateController.text)
                  );

                  ref.read(destinationNotifierProvider.notifier).updateDestination(update);
                  context.pop();
                });
              }, 
              child: const Text(
                'S A V E    C H A N G E S'
              )),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2050)
      );
    
    if (picked != null){
      setState(() {
        _visitDateController.text = format.format(picked);
      });
    }
  }
}
