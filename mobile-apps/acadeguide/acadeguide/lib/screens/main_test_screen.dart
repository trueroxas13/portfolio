import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/providers/assessed_provider.dart';
import 'package:acadeguide/providers/majors_provider.dart';
import 'package:acadeguide/providers/questions_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainTestScreen extends ConsumerStatefulWidget {
  const MainTestScreen({super.key});

  @override
  ConsumerState<MainTestScreen> createState() => _MainTestScreenState();
}

class _MainTestScreenState extends ConsumerState<MainTestScreen> {
  Stopwatch stopwatch = Stopwatch()..start();

  final Decorations _decorations = Decorations();
  final _authService = AuthService();
  List<String> options = List.filled(10, "default", growable: false);
  List<List<String>> selected =
      List.generate(10, (i) => ["default"], growable: false);
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Before you start!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 61, 82, 175),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Take your time and answer honestly! Choose 1–2 options per question that describe you best. Your answers will help us recommend majors that truly match your vibe.",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color.fromARGB(255, 80, 80, 100),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 61, 82, 175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Got it!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Map? user = _authService.getUserData();
    String? username = user?['username'];
    String? firstname = user?['firstname'];
    String? lastname = user?['lastname'];
    // Fetch the list of questions from the provider
    var questions = ref.watch(questionsNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: _decorations.screenHeading('ASSESSMENT'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView.builder(
          itemCount: questions.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 250, 252),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromARGB(255, 220, 220, 225),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2, right: 10),
                      child: Icon(
                        Icons.info_outline,
                        size: 18,
                        color: const Color.fromARGB(255, 100, 100, 120),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Answer all questions. Select 1-2 options that best describe you.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: const Color.fromARGB(255, 80, 80, 100),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Submit button at the end
            if (index == questions.length + 1) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () async {
                          for (List<String> x in selected) {
                            for (String y in x) {
                              if (y == "default") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    _decorations.bottomPopup(
                                        "Please answer all questions!",
                                        const Color.fromARGB(
                                            255, 250, 123, 123),
                                        Colors.white));
                                return;
                              }
                            }
                          }

                          setState(() {
                            _isSubmitting = true;
                          });

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return PopScope(
                                canPop: false,
                                child: Dialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            const Color.fromARGB(
                                                255, 61, 82, 175),
                                          ),
                                          strokeWidth: 3,
                                        ),
                                        SizedBox(height: 24),
                                        Text(
                                          "Processing Your Results",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromARGB(
                                                255, 61, 82, 175),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          "Please wait while we analyze your responses...",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: const Color.fromARGB(
                                                255, 100, 100, 120),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          List<String> selectedOptions = [];
                          for (List<String> x in selected) {
                            selectedOptions.addAll(x);
                          }
                          String resultString = selectedOptions.join(", ");

                          await ref
                              .read(majorsProvider.notifier)
                              .recommendMajors(
                                  selectedOptions, _authService.getUser()!);

                          await _authService.updateUserData(
                              username!, firstname!, lastname!, resultString).then((value) {
                                stopwatch.stop();
                                print('Assessment completed in: ${stopwatch.elapsed.inSeconds} seconds');
                              },);

                          await Future.delayed(
                              const Duration(milliseconds: 1500));
                          ref
                              .read(assessedNotifierProvider.notifier)
                              .setFalse();
                          if (mounted) {
                            Navigator.of(context, rootNavigator: true)
                                .popUntil((route) => route.isFirst);
                            context.goNamed(AppRouter.result.name);
                          }
                        },
                  style: _decorations.submitButtonStyle(),
                  child: _isSubmitting
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : _decorations.cardButtonText("E M B A R K"),
                ),
              );
            }

            // Question cards
            final questionIndex = index - 1;
            final question = questions[questionIndex];
            return Card(
              elevation: 1,
              color: questionIndex % 2 == 0
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(255, 255, 255, 255),
              child: GestureDetector(
                onTap: () async {},
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${questionIndex + 1} - ${question.questionText!}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: questionIndex % 2 == 0
                                      ? const Color.fromARGB(255, 255, 127, 7)
                                      : const Color.fromARGB(255, 61, 82, 175),
                                ),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 5),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: question.answers!.length,
                          itemBuilder: (context, ansIndex) {
                            final answer = question.answers![ansIndex];

                            bool hasNA = selected[questionIndex].any((trait) {
                              var matchingAnswer = question.answers!.firstWhere(
                                (ans) => ans.trait == trait,
                                orElse: () => answer,
                              );
                              return matchingAnswer.text!.contains("N/A");
                            });

                            bool isNA = answer.text!.contains("N/A");

                            bool isEnabled = true;

                            if (!selected[questionIndex]
                                .contains(answer.trait!)) {
                              if (selected[questionIndex].length > 1 &&
                                  !selected[questionIndex]
                                      .contains("default")) {
                                isEnabled = false;
                              } else if (isNA &&
                                  selected[questionIndex].isNotEmpty &&
                                  !selected[questionIndex]
                                      .contains("default")) {
                                isEnabled = false;
                              } else if (!isNA && hasNA) {
                                isEnabled = false;
                              }
                            }
                            return CheckboxListTile(
                                title: Text(
                                  answer.text!,
                                  style: TextStyle(
                                    color: questionIndex % 2 == 0
                                        ? const Color.fromARGB(
                                            255, 201, 113, 78)
                                        : const Color.fromARGB(
                                            255, 90, 108, 187),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                value: selected[questionIndex]
                                    .contains(answer.trait!),
                                shape: RoundedRectangleBorder(),
                                side: BorderSide(
                                  color: questionIndex % 2 == 0
                                      ? const Color.fromARGB(255, 201, 113, 78)
                                      : const Color.fromARGB(255, 90, 108, 187),
                                  width: 2,
                                ),
                                onChanged: !isEnabled
                                    ? null
                                    : (value) {
                                        setState(() {
                                          if (value == true) {
                                            if (selected[questionIndex]
                                                .contains("default")) {
                                              selected[questionIndex]
                                                  .remove("default");
                                            }
                                            selected[questionIndex]
                                                .add(answer.trait!);
                                          } else {
                                            selected[questionIndex]
                                                .remove(answer.trait!);

                                            if (selected[questionIndex]
                                                .isEmpty) {
                                              selected[questionIndex]
                                                  .add("default");
                                            }
                                          }
                                        });
                                      });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
