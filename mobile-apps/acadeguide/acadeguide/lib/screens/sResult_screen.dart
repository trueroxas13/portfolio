import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/models/testResults.dart';
import 'package:acadeguide/providers/result_provider.dart';
import 'package:acadeguide/providers/university_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SResultScreen extends ConsumerStatefulWidget {
  final String resultId;
  const SResultScreen({super.key, required this.resultId});

  @override
  ConsumerState<SResultScreen> createState() => _SResultScreenState();
}

class _SResultScreenState extends ConsumerState<SResultScreen> {
  final _authService = AuthService();
  final Decorations _decorations = Decorations();

  @override
  Widget build(BuildContext context) {
    ref.watch(universityNotifierProvider);

    late String? uid = _authService.getUser();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Animate(
        effects: [
          FadeEffect(duration: 300.ms),
          ScaleEffect(duration: 300.ms, begin: Offset(0.8, 0.8)),
        ],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _decorations.heading("R E S U L T"),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "Viewing previous record...",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 78, 76, 175),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Testresults>>(
                  future: ref
                      .read(resultNotifierProvider.notifier)
                      .getUserResults(uid!),
                  builder: (context, snapshot) {
                    print(uid);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      print('Error: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.hasData) {
                      final results = snapshot.data!;
                      if (results.isNotEmpty) {
                        // Sort results by timestamp/date to get the most recent
                        results.sort((a, b) {
                          if (a.date_time != null && b.date_time != null) {
                            return b.date_time!.compareTo(a.date_time!);
                          }
                          return 0;
                        });
                        
                        final latestResult = results.firstWhere((element) => element.id == int.parse(widget.resultId),);

                        return ListView.builder(
                          itemCount: latestResult.recommendedMajors!.length,
                          itemBuilder: (context, index) {
                            final major =
                                latestResult.recommendedMajors![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: index % 2 == 0
                                    ? const Color.fromARGB(255, 255, 236, 228)
                                    : const Color.fromARGB(
                                        255, 232, 236, 255),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        major.majorName!,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Divider(
                                          thickness: 5,
                                          color: const Color.fromARGB(
                                              255, 117, 123, 151)),
                                      Text(
                                        "Offered by the following institution(s)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ListView.builder(
                                        physics:
                                            NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            major.offeredByUniversity!.length,
                                        itemBuilder: (context, uniIndex) {
                                          if (major.offeredByUniversity ==
                                              null) {
                                            return Container();
                                          }
                                          if (major.offeredByUniversity!
                                              .isNotEmpty) {
                                            final uni = ref
                                                .read(
                                                    universityNotifierProvider
                                                        .notifier)
                                                .getUniversityById(major
                                                        .offeredByUniversity![
                                                    uniIndex]);
                                            return Row(
                                              children: [
                                                GestureDetector(
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: uni.uniLogo!
                                                            .endsWith('.svg')
                                                        ? SvgPicture.asset(
                                                            'assets/uniLogos/${uni.uniLogo}')
                                                        : Image.asset(
                                                            'assets/uniLogos/${uni.uniLogo}',
                                                            fit: BoxFit
                                                                .contain),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "${uni.uniName!} - ${uni.uniCity}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(child: Text('No results found'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              ElevatedButton.icon(
                style: _decorations.cardButtonStyle(
                  const Color.fromARGB(255, 255, 245, 214),
                ),
                icon: Icon(Icons.arrow_circle_right_outlined, color: const Color(0xFFFF7F07), size: 30),
                label: _decorations.cardButtonText("Retake Assessment"),
                onPressed: (){
                  //ref.watch(assessedNotifierProvider.notifier).setFalse();
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    context.goNamed(AppRouter.test.name);  
                  },);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
