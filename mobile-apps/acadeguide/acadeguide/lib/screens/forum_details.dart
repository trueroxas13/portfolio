import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/models/discussion_forum.dart';
import 'package:acadeguide/models/forum_reply.dart';
import 'package:acadeguide/providers/forum_provider.dart';
import 'package:acadeguide/providers/reply_provider.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ForumDetails extends ConsumerStatefulWidget {
  final String forumId;
  const ForumDetails({super.key, required this.forumId});

  @override
  ConsumerState<ForumDetails> createState() => _ForumDetailsState();
}

class _ForumDetailsState extends ConsumerState<ForumDetails> {
  final Decorations _decorations = Decorations();
  final TextEditingController _replyController = TextEditingController();
  final _authService = AuthService();

  int _refreshKey = 0;
  Future<void> _refreshData() async {
    setState(() {
      _refreshKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = _authService.getUser();
    final user = _authService.getUserData();
    String? username = user?["username"];

    //add isAdmin check
    bool isAdmin = true;

    final postFuture = ref
        .read(forumNotifierProvider.notifier)
        .getPostById(int.parse(widget.forumId));

    final repliesFuture = ref
        .read(replyNotifierProvider.notifier)
        .getRepliesByPostId(int.parse(widget.forumId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: _decorations.screenHeading("FORUMS"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshData();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Discussionforum>(
            key: ValueKey(_refreshKey),
            future: postFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final post = snapshot.data!;
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 1,
                      color: const Color.fromARGB(255, 61, 82, 175),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      post.subject!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 249, 236)),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(Icons.person_outlined, size: 22),
                                  Expanded(
                                    child: Text(
                                      post.userId!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 255, 249, 236)),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(height: 5),
                              Text(
                                post.description!,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 255, 249, 236)),
                                softWrap: true,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat('dd MMM yyyy')
                                              .format(post.date_time!),
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 249, 236),
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Scaffold(
                                                backgroundColor:
                                                    Colors.transparent,
                                                body: Dialog(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  insetPadding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2.5,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Reply",
                                                              style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    230,
                                                                    130,
                                                                    90),
                                                                letterSpacing:
                                                                    0.5,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 16),
                                                            TextField(
                                                              controller:
                                                                  _replyController,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Write your response here...',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            230,
                                                                            130,
                                                                            90)
                                                                        .withAlpha(
                                                                            77),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        230,
                                                                        130,
                                                                        90),
                                                                    width: 2,
                                                                  ),
                                                                ),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          230,
                                                                          130,
                                                                          90)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            16),
                                                              ),
                                                              maxLines: 8,
                                                              scrollPhysics:
                                                                  ScrollPhysics(),
                                                            ),
                                                            SizedBox(
                                                                height: 24),
                                                            Center(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (_replyController
                                                                          .text ==
                                                                      "") {
                                                                    print(
                                                                        "here");
                                                                    ScaffoldMessenger.of(
                                                                            dialogContext)
                                                                        .showSnackBar(
                                                                      _decorations
                                                                          .bottomPopup(
                                                                        "Please type a message and try again.",
                                                                        const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            250,
                                                                            123,
                                                                            123),
                                                                        Colors
                                                                            .white,
                                                                      ),
                                                                    );
                                                                    return;
                                                                  }

                                                                  final confirmed =
                                                                      await showDialog<
                                                                          bool>(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                        ),
                                                                        title: Text(
                                                                            'Confirm reply'),
                                                                        content:
                                                                            Text('Are you sure you want to post this reply?'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, false),
                                                                            child:
                                                                                Text(
                                                                              'Cancel',
                                                                              style: TextStyle(
                                                                                color: Colors.grey[600],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, true),
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: const Color.fromARGB(255, 206, 86, 38),
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              elevation: 0,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              'Post',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );

                                                                  if (confirmed !=
                                                                      true) {
                                                                    return;
                                                                  }

                                                                  try {
                                                                    final reply =
                                                                        Forumreply(
                                                                      userId:
                                                                          username,
                                                                      discussionId:
                                                                          int.parse(
                                                                              widget.forumId),
                                                                      reply: _replyController
                                                                          .text,
                                                                      date_time:
                                                                          DateTime
                                                                              .now(),
                                                                    );
                                                                    ref
                                                                        .read(replyNotifierProvider
                                                                            .notifier)
                                                                        .addReply(
                                                                            reply);

                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      _decorations
                                                                          .bottomPopup(
                                                                        "Comment posted ✅",
                                                                        Color.fromARGB(
                                                                            255,
                                                                            76,
                                                                            175,
                                                                            80),
                                                                        Colors
                                                                            .white,
                                                                      ),
                                                                    );

                                                                    Navigator.of(
                                                                            dialogContext)
                                                                        .pop();

                                                                    // Refresh after adding reply
                                                                    _refreshData();
                                                                  } catch (e) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      _decorations
                                                                          .bottomPopup(
                                                                        'Error posting reply',
                                                                        Colors
                                                                            .red,
                                                                        Colors
                                                                            .white,
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                style: _decorations
                                                                    .submitButtonStyle(),
                                                                child: _decorations
                                                                    .buttonText(
                                                                        "P O S T"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                          });
                                    },
                                    child: Card(
                                        color: const Color.fromARGB(
                                            255, 232, 236, 255),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(Icons.reply, size: 30),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Reply",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 249, 236),
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(thickness: 5),
                    SizedBox(height: 5),
                    _decorations.subHeading("C O M M E N T S"),
                    FutureBuilder<List<Forumreply>>(
                      key: ValueKey(
                          'replies_$_refreshKey'), // Force rebuild on refresh
                      future: repliesFuture,
                      builder: (context, replySnapshot) {
                        if (replySnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (replySnapshot.data == null) {
                          print("null retrieved");
                          return Container();
                        }
                        final replies = replySnapshot.data!;

                        if (replies.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "\n\nThis post has no comments... yet :)",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: const Color.fromARGB(
                                        255, 187, 190, 194)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: replies.length,
                          itemBuilder: (context, replyIndex) {
                            final reply =
                                replies[replies.length - 1 - replyIndex];
                            print(uid);
                            print(reply.userId);
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Profile icon
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color.fromARGB(
                                          255, 61, 82, 175),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Reply content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Username or ID
                                          Text(
                                            reply.userId!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: const Color.fromARGB(
                                                      255, 61, 82, 175)
                                                  .withValues(alpha: 0.7),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            DateFormat('MMM dd')
                                                .format(reply.date_time!),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          Text(
                                            reply.reply ?? "",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              height: 1.5,
                                              color: Color.fromARGB(
                                                  255, 70, 70, 90),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FutureBuilder<bool>(
                                      future: _authService.isAdmin(uid!),
                                      builder: (context, adminSnapshot) {
                                        final showDelete = post.userId == uid ||
                                            post.userId == username ||
                                            (adminSnapshot.data ?? false);

                                        return PopupMenuButton<String>(
                                          padding: EdgeInsets.only(bottom: 23),
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.grey[700],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          offset: Offset(0, 40),
                                          color: Colors.white,
                                          itemBuilder: (BuildContext context) {
                                            List<PopupMenuEntry<String>> items =
                                                [];
                                            if (showDelete) {
                                              items.add(
                                                PopupMenuItem<String>(
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.delete,
                                                          color: Colors.red,
                                                          size: 20),
                                                      SizedBox(width: 12),
                                                      Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                            return items;
                                          },
                                          onSelected: (String value) async {
                                            if (value == 'delete') {
                                              final confirmed =
                                                  await showDialog<bool>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    title: Text(
                                                        'Confirm Deletion'),
                                                    content: Text(
                                                        'Are you sure you want to delete this reply?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, false),
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, true),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  206, 86, 38),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          elevation: 0,
                                                        ),
                                                        child: Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );

                                              if (confirmed != true) {
                                                return;
                                              }

                                              ref
                                                  .read(replyNotifierProvider
                                                      .notifier)
                                                  .removeReply(reply.id!);
                                              _refreshData();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      _decorations.bottomPopup(
                                                          "Reply Deleted",
                                                          Colors.green,
                                                          Colors.white));
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
