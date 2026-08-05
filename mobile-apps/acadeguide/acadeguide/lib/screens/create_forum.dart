import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/models/discussion_forum.dart';
import 'package:acadeguide/providers/forum_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateForumscreen extends ConsumerStatefulWidget {
  const CreateForumscreen({super.key});

  @override
  ConsumerState<CreateForumscreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends ConsumerState<CreateForumscreen> {
  final AuthService _authService = AuthService();
  final Decorations _decorations = Decorations();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? userid = _authService.getUser();
    final user = _authService.getUserData();
    String? username = user?["username"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: _decorations.screenHeading('FORUMS'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'N E W    P O S T',
                style: TextStyle(fontSize: 20, color: Colors.red),
              )
                  .animate(onPlay: (controller) => controller.loop())
                  .tint(color: Colors.lightBlue, duration: 10.seconds)
                  .then(delay: 1.seconds)
                  .tint(color: Colors.red, duration: 10.seconds),
              SizedBox(height: 20),
              Text(
                "Got a question or have useful information to share?\nCreate a post about it!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "S U B J E C T",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 61, 82, 175),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        hintText: 'What are you writing about?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 109, 130, 226),
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "C O N T E N T",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 206, 86, 38),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Write what you wish to inquire or share!',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 230, 130, 90),
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      maxLines: 13,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_subjectController.text.trim().isEmpty ||
                      _descriptionController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(_decorations.bottomPopup(
                      "Please fill out the required fields",
                      Colors.red,
                      Colors.white,
                    ));

                    return;
                  }
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Post'),
                        content:
                            Text('Are you sure you want to post this forum?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 206, 86, 38),
                            ),
                            child: Text('Post',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmed != true) return;

                  try {
                    final newForum = Discussionforum(
                      userId: username,
                      subject: _subjectController.text.trim(),
                      description: _descriptionController.text.trim(),
                      date_time: DateTime.now(),
                    );
                    
                    Stopwatch stopwatch = Stopwatch()..start();
                    ref.read(forumNotifierProvider.notifier).addPost(newForum);
                    stopwatch.stop();
                    print('Time taken to add forum post: ${stopwatch.elapsedMilliseconds} ms');
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                        _decorations.bottomPopup("Forum posted successfully",
                            Colors.green, Colors.white));

                    context.goNamed(AppRouter.forum.name);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        _decorations.bottomPopup(
                            'Error creating post', Colors.red, Colors.white));
                  }
                },
                style: _decorations.submitButtonStyle(),
                child: _decorations.buttonText('P O S T'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
