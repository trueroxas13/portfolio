import 'package:acadeguide/models/university.dart';
import 'package:acadeguide/providers/university_provider.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class UniDetails extends ConsumerStatefulWidget {
  final String uniId;
  const UniDetails({super.key, required this.uniId});

  @override
  ConsumerState<UniDetails> createState() => _UniDetailsState();
}

class _UniDetailsState extends ConsumerState<UniDetails> {
  University uni = University();
  List<University> unis = [];
  final Decorations _decorations = Decorations();
  bool _showAllMajors = false;

  @override
  Widget build(BuildContext context) {
    unis = ref.watch(universityNotifierProvider);
    uni = unis.firstWhere((x) => x.uniID == widget.uniId);

    final majorsToShow = uni.uniMajors != null && uni.uniMajors!.isNotEmpty
        ? (_showAllMajors ? uni.uniMajors! : uni.uniMajors!.take(7).toList())
        : [];
    final hasMoreMajors = uni.uniMajors != null && uni.uniMajors!.length > 7;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: _decorations.screenHeading(uni.uniName!),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(children: [
              SizedBox(
                height: 300,
                child: uni.uniLogo!.endsWith('.svg')
                    ? SvgPicture.asset('assets/uniLogos/${uni.uniLogo}')
                    : Image.asset('assets/uniLogos/${uni.uniLogo}'),
              ),
              SizedBox(height: 30),
              Text(
                'About',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: const Color.fromARGB(255, 61, 82, 175),
                ),
              ),
              SizedBox(height: 15),
              if (uni.uniDescription != null && uni.uniDescription!.isNotEmpty)
                Text(
                  uni.uniDescription!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 80, 80, 80),
                    height: 1.5,
                  ),
                ),
              SizedBox(height: 30),
              Card(
                color: const Color.fromARGB(255, 255, 236, 228),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.school,
                              color: const Color.fromARGB(255, 206, 86, 38)),
                          SizedBox(width: 10),
                          Text(
                            'Institution Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        uni.uniType ?? 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 105, 105, 105),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: const Color.fromARGB(255, 232, 236, 255),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money,
                              color: const Color.fromARGB(255, 61, 82, 175)),
                          SizedBox(width: 10),
                          Text(
                            'Tuition Fee',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        uni.tuitionAvg != null && uni.tuitionAvg! > 0
                            ? 'QAR ${uni.tuitionAvg}'
                            : 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 105, 105, 105),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: const Color.fromARGB(255, 255, 236, 228),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: const Color.fromARGB(255, 206, 86, 38)),
                          SizedBox(width: 10),
                          Text(
                            'Location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${uni.uniCity}, ${uni.uniCountry}',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 105, 105, 105),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: const Color.fromARGB(255, 232, 236, 255),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.language,
                              color: const Color.fromARGB(255, 61, 82, 175)),
                          SizedBox(width: 10),
                          Text(
                            'Website',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse('${uni.uniWebsite}');
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Text(
                          '${uni.uniWebsite}',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 105, 105, 105),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (uni.uniMajors != null && uni.uniMajors!.isNotEmpty) ...[
                SizedBox(height: 30),
                Text(
                  'Available Majors',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: const Color.fromARGB(255, 61, 82, 175),
                  ),
                ),
                SizedBox(height: 15),
                Card(
                  color: const Color.fromARGB(255, 255, 236, 228),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.menu_book,
                                color: const Color.fromARGB(255, 206, 86, 38)),
                            SizedBox(width: 10),
                            Text(
                              'Programs Offered',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        ...majorsToShow.map((major) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color:
                                        const Color.fromARGB(255, 61, 82, 175),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      major ?? 'Unknown Major',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: const Color.fromARGB(
                                            255, 80, 80, 80),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        if (hasMoreMajors) ...[
                          SizedBox(height: 10),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _showAllMajors = !_showAllMajors;
                                });
                              },
                              child: Text(
                                _showAllMajors
                                    ? 'Show Less'
                                    : 'Show More (${uni.uniMajors!.length - 7} more)',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 206, 86, 38),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 30),
            ]),
          ),
        ));
  }
}
