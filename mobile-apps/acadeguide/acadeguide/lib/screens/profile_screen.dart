import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/models/testResults.dart';
import 'package:acadeguide/providers/result_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _authService = AuthService();
  final Decorations _decorations = Decorations();

  @override
  Widget build(BuildContext context) {
    final user = _authService.getUserData();
    final username = user?['username'] ?? '';
    final firstname = user?['firstname'] ?? '';
    final lastname = user?['lastname'] ?? '';
    final uid = _authService.getUser();
    final interests = user?['interests'] ?? '';

    List<String> ints = interests.split(', ');
    ints.removeWhere(
      (element) => element.isEmpty,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: _decorations.screenHeading('PROFILE')),
      body: Animate(
        effects: [
          FadeEffect(duration: 300.ms),
          ScaleEffect(duration: 300.ms, begin: const Offset(0.95, 0.95)),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildStudentDetailsCard(username, firstname, lastname),
                const SizedBox(height: 20),
                _decorations.subHeading('INTERESTS | TRAITS'),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: ints.isEmpty ? 150 : 350,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(77),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: ints.isEmpty
                          ? const Text(
                              'No interests added. Get started by taking our simple assessment in the dashboard!',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: ints.length,
                              itemBuilder: (context, index) {
                                return _decorations.displayCard(
                                    ints[index], index);
                              },
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _decorations.subHeading('PREVIOUS RESULTS'),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(77),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder(
                          future: ref
                              .read(resultNotifierProvider.notifier)
                              .getUserResults(uid!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              final error = snapshot.error.toString();

                              // Check if it's a network error
                              if (error.contains('SocketException') ||
                                  error.contains('Failed host lookup') ||
                                  error.contains('ClientException')) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.wifi_off,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'No Internet Connection',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Please check your connection and try again',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 24),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.refresh),
                                        label: Text('Retry'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 127, 7),
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              // For other errors
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error_outline,
                                        size: 64, color: Colors.grey),
                                    SizedBox(height: 16),
                                    Text(
                                      'Something went wrong',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      child: Text(
                                        error,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () => setState(() {}),
                                      child: Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final results = snapshot.data ?? [];
                              if (results.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'No previous results found.',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                              results.sort((a, b) =>
                                  b.date_time!.compareTo(a.date_time!));
                              return ListView.builder(
                                itemCount: results.length,
                                itemBuilder: (context, index) {
                                  final Testresults result = results[index];
                                  final formattedDate = DateFormat.yMMMd()
                                      .format(result.date_time!);
                                  return _decorations.displayCardButton(
                                      formattedDate, index, () {
                                    context.goNamed(AppRouter.sresult.name,
                                        pathParameters: {
                                          'id': "${result.id!}"
                                        });
                                  });
                                },
                              );
                            }
                          }),
                    ),
                  ),
                )
              ],
            ),
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
    );
  }

  Widget _buildStudentDetailsCard(
      String username, String firstname, String lastname) {
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
            color:
                const Color.fromARGB(255, 255, 136, 0).withValues(alpha: 0.3),
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
              children: const [
                Icon(Icons.person_outline, size: 38, color: Color(0xFFFFF9EC)),
                SizedBox(width: 8),
                Text(
                  'DETAILS',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Color(0xFFFFF9EC),
                  ),
                ),
              ],
            ),
            const Divider(color: Color(0xFFFFF9EC)),
            const SizedBox(height: 8),
            Text(
              "Username:    $username \nFirst Name:  $firstname \nLast Name:  $lastname",
              style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFF9EC),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _decorations.buildCardButton(
              label: 'Edit',
              icon: Icons.edit_outlined,
              onPressed: () {
                editProfileDialog(context, username, firstname, lastname);
              },
            ),
          ],
        ),
      ),
    );
  }

  void editProfileDialog(BuildContext context, String username,
      String firstname, String lastname) {
    final usernameController = TextEditingController(text: username);
    final firstnameController = TextEditingController(text: firstname);
    final lastnameController = TextEditingController(text: lastname);

    final user = _authService.getUserData();
    final interests = user?['interests'] ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 230, 130, 90),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: usernameController,
                          decoration: _decorations.fieldEntry(
                              'Username', const Icon(Icons.person_outline)),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: firstnameController,
                          decoration: _decorations.fieldEntry(
                              'First Name', const Icon(Icons.badge_outlined)),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: lastnameController,
                          decoration: _decorations.fieldEntry(
                              'Last Name', const Icon(Icons.badge_outlined)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            ElevatedButton(
                              style: _decorations.submitButtonStyle(),
                              onPressed: () async {
                                if (usernameController.text.trim().isEmpty ||
                                    firstnameController.text.trim().isEmpty ||
                                    lastnameController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(dialogContext)
                                      .showSnackBar(_decorations.bottomPopup(
                                    "Please fill out all fields",
                                    Colors.red,
                                    Colors.white,
                                  ));
                                  return;
                                }
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      title: Text('Confirm Edit'),
                                      content: Text(
                                          'Are you sure you want to update your profile?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 206, 86, 38),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: Text(
                                            'Edit',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmed != true) {
                                  return;
                                }

                                await _authService.updateUserData(
                                  usernameController.text.trim(),
                                  firstnameController.text.trim(),
                                  lastnameController.text.trim(),
                                  interests,
                                );
                                Navigator.of(dialogContext).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_decorations.bottomPopup(
                                  "Profile updated successfully",
                                  Colors.green,
                                  Colors.white,
                                ));
                                setState(() {});
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 230, 130, 90),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
