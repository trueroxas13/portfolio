import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/models/major.dart';
import 'package:acadeguide/models/testResults.dart';
import 'package:acadeguide/providers/assessed_provider.dart';
import 'package:acadeguide/providers/result_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final _authService = AuthService();
  final Decorations _decorations = Decorations();
  Testresults latest = Testresults();
  List<Majors> majors = [];

  @override
  Widget build(BuildContext context) {
    final user = _authService.getUserData();
    final username = user?['username'] ?? '';
    final firstname = user?['firstname'] ?? '';
    final lastname = user?['lastname'] ?? '';
    final uid = _authService.getUser();
    bool isAdmin = false;

    bool assessed = ref.watch(assessedNotifierProvider);

    if (!assessed) {
      ref.read(resultNotifierProvider.notifier).getUserResults(uid!).then(
        (value) {
          if (value.isNotEmpty) {
            print("i found results");
            setState(() {
              value.sort(
                (a, b) {
                  return a.date_time!.compareTo(b.date_time!);
                },
              );
              latest = value.last;
              majors = latest.recommendedMajors!;
              assessed = true;
              ref.read(assessedNotifierProvider.notifier).setTrue();
            });
          }
        },
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hi, $username 👋',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Color.fromARGB(255, 61, 82, 175),
              ),
            ),
          ),
        ),
        body: Animate(
          effects: [
            FadeEffect(duration: 300.ms),
            ScaleEffect(duration: 300.ms, begin: const Offset(0.95, 0.95)),
          ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildStudentCard(username, firstname, lastname, uid!),
                const SizedBox(height: 20),
                _buildAssessmentCard(context, assessed),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed(AppRouter.chatbot.name);
          },
          backgroundColor: const Color.fromARGB(255, 0, 98, 244),
          child: const Icon(Icons.smart_toy,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }

  Widget _buildStudentCard(
      String username, String firstname, String lastname, String uid) {
    return FutureBuilder<bool>(
      future: _authService.isAdmin(uid),
      builder: (context, snapshot) {
        final isAdmin = snapshot.data ?? false;

        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 230, 99, 12), // deep orange
                Color.fromARGB(255, 241, 134, 27), // lighter metallic orange
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 255, 136, 0)
                    .withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(Icons.person,
                              size: 38, color: Color(0xFFFFF9EC)),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'STUDENT CARD',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                                color: Color(0xFFFFF9EC),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isAdmin)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF9EC),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.admin_panel_settings,
                              size: 16,
                              color: Color.fromARGB(255, 230, 99, 12),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'ADMIN',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                color: Color.fromARGB(255, 230, 99, 12),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const Divider(color: Color(0xFFFFF9EC)),
                const SizedBox(height: 8),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFF9EC),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '$firstname $lastname',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFF9EC),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                const Text(
                  'No bio assigned.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFFF9EC),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                _decorations.buildCardButton(
                  label: 'Profile',
                  icon: Icons.person_outline_outlined,
                  onPressed: () {
                    context.goNamed(AppRouter.profile.name);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAssessmentCard(BuildContext context, bool assessed) {
    final isDone = assessed;
    final recMajors = majors.length >= 3
        ? '${majors[0].majorName} | ${majors[1].majorName} | ${majors[2].majorName}'
        : majors.isNotEmpty
            ? majors.map((m) => m.majorName ?? "N/A").join(" | ")
            : "No recommended majors found.";

    final text = isDone
        ? 'Suitable Majors: $recMajors\n\nLocal university options available!'
        : 'Looks like you haven\'t taken your assessment yet.\n\n'
            'Get started by taking our simple test below!';

    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isDone ? Icons.check_circle : Icons.edit_note,
                  size: 36,
                  color: const Color.fromARGB(255, 8, 240, 58),
                ),
                const SizedBox(width: 8),
                const Text(
                  'ASSESSMENT',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Color.fromARGB(255, 61, 82, 175),
                  ),
                ),
              ],
            ),
            const Divider(color: Color.fromARGB(255, 61, 82, 175)),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            _decorations.buildCardButton(
                label: isDone ? 'View Details' : 'Get Started',
                icon: Icons.arrow_circle_right_outlined,
                onPressed: () {
                  if (!assessed) {
                    context.goNamed(AppRouter.test.name);
                  } else {
                    context.goNamed(AppRouter.result.name);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
