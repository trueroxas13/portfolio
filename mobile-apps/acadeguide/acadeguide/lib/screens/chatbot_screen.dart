import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/providers/result_provider.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ChatbotScreen extends ConsumerStatefulWidget {
  const ChatbotScreen({super.key});

  @override
  ConsumerState<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends ConsumerState<ChatbotScreen> {
  final Gemini gemini = Gemini.instance;
  final Decorations _decorations = Decorations();

  final _authService = AuthService();
  late Map? user = _authService.getUserData();
  late String? uid = _authService.getUser();
  late String? username = user?['username'];
  late String? interests = user?['interests'];
  List<ChatMessage> messages = [];

  late ChatUser currentUser = ChatUser(
    id: uid!,
    firstName: username,
  );
  ChatUser botUser = ChatUser(
    id: '1',
    firstName: 'Rasheed',
  );

  late final String systemPrompt = """
You are an Academic Advisor chatbot your name is Rasheed. You MUST ONLY respond to questions related to:
- Academic roadmaps and course selection
- Degree programs and requirements in Qatar based on the university (If you dont have the available data, politely inform the user that you don't have that information)
- Academic planning and advising
- Study tips and academic resources
- University policies and procedures
- Career guidance related to academics

If a user asks you to recommend majors for him please consider his interests: $interests if it exists if not ask him to talk about his interests first or take the exam before recommending any majors.
If a user asks about ANY topic outside of these areas (such as general knowledge, entertainment, cooking, sports, politics, etc.), you MUST politely decline and redirect them back to academic topics.Make tsure it's clear and to point dont repeat what you said before.
Dont make your responses too long and keep them concise and to the point.
Response format for off-topic questions:
"I'm your Academic Advisor and can only help with academic-related questions. Please ask me about courses, degree programs, registration, study tips, or other academic matters."

Always be helpful, professional, and supportive when answering academic questions.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: _decorations.screenHeading('RASHEED')),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        DashChat(
          messages: messages,
          currentUser: currentUser,
          onSend: _sendMessage,
          inputOptions: InputOptions(
            inputDecoration: InputDecoration(
              hintText: "Ask Rasheed...",
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            alwaysShowSend: true,
            sendButtonBuilder: (send) => IconButton(
              onPressed: send,
              icon: Icon(Icons.send_rounded,
                  color: Theme.of(context).primaryColor, size: 24),
            ),
          ),
          messageOptions: MessageOptions(
            messageRowBuilder: (message, previousMessage, nextMessage,
                isAfterDateSeparator, isBeforeDateSeparator) {
              bool isBot = message.user.id == botUser.id;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment:
                      isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isBot
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: isBot
                            ? Markdown(
                                data: message.text,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                styleSheet: MarkdownStyleSheet.fromTheme(
                                  Theme.of(context).copyWith(
                                    textTheme: const TextTheme(
                                      bodyMedium: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                message.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Empty state widget
        if (messages.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/rasheed1.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Hello I\'m Rasheed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      String accumulatedResponse = "";
      String fullPrompt = "$systemPrompt\n\n$question\n";

      gemini.promptStream(parts: [Part.text(fullPrompt)]).listen((value) {
        String currentChunk = value?.output ?? "";

        // Accumulate the response
        accumulatedResponse += currentChunk;

        setState(() {
          ChatMessage? lastMessage =
              messages.isNotEmpty ? messages.first : null;

          if (lastMessage != null && lastMessage.user.id == botUser.id) {
            messages[0] = ChatMessage(
              text: accumulatedResponse,
              user: botUser,
              createdAt: lastMessage.createdAt,
            );
          } else {
            ChatMessage botMessage = ChatMessage(
              text: accumulatedResponse,
              user: botUser,
              createdAt: DateTime.now(),
            );
            messages = [botMessage, ...messages];
          }
        });
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}
