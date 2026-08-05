import 'package:acadeguide/auth/auth_service.dart';
import 'package:acadeguide/models/discussion_forum.dart';
import 'package:acadeguide/models/forum_reply.dart';
import 'package:acadeguide/providers/forum_provider.dart';
import 'package:acadeguide/providers/reply_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Forumscreen extends ConsumerStatefulWidget {
  const Forumscreen({super.key});

  @override
  ConsumerState<Forumscreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends ConsumerState<Forumscreen> {
  final Decorations _decorations = Decorations();
  final TextEditingController _searchController = TextEditingController();
  final AuthService _authService = AuthService();
  String _searchQuery = '';
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = _authService.getUser();
    final user = _authService.getUserData();
    String? username = user?["username"];

    //add isAdmin check
    bool isAdmin = true;

    bool isFetching = true;
    Stopwatch stopwatch = Stopwatch()..start();

    int _refreshKey = 0;
    Future<void> _refreshData() async {
      setState(() {
        _refreshKey++;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: _decorations.screenHeading('FORUMS'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _searchQuery = _searchController.text;
          });
          _refreshData();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "S E A R C H",
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 61, 82, 175),
                          ),
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.search,
                            color: const Color.fromARGB(255, 61, 82, 175),
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase().trim();
                          });
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context.goNamed(AppRouter.newForum.name);
                        },
                        icon: Icon(Icons.add_circle,
                            size: 50,
                            color: const Color.fromARGB(255, 206, 86, 38)))
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<Discussionforum>>(
                  key: ValueKey(_refreshKey),
                  stream: ref.read(forumNotifierProvider.notifier).getPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
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
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 127, 7),
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
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                error,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
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
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No forums available'));
                    }

                    if (isFetching) {
                      stopwatch.stop();
                      print(
                          'Time taken to fetch forums: ${stopwatch.elapsedMilliseconds} ms');
                      isFetching = false;
                    }

                    final allPosts = snapshot.data!;

                    // Filter posts based on search query
                    final filteredPosts = _searchQuery.isEmpty
                        ? allPosts
                        : allPosts.where((post) {
                            final subject = post.subject?.toLowerCase() ?? '';
                            final description =
                                post.description?.toLowerCase() ?? '';
                            final userId = post.userId?.toLowerCase() ?? '';

                            return subject.contains(_searchQuery) ||
                                description.contains(_searchQuery) ||
                                userId.contains(_searchQuery);
                          }).toList();

                    if (filteredPosts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchQuery.isEmpty
                                  ? Icons.forum_outlined
                                  : Icons.search_off,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              _searchQuery.isEmpty
                                  ? 'No forums found...'
                                  : 'No forums match "$_searchQuery"',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post =
                            filteredPosts[filteredPosts.length - 1 - index];

                        return Card(
                          elevation: 2,
                          margin:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              context.goNamed(AppRouter.forumDetails.name,
                                  pathParameters: {
                                    'id': post.discussionId!.toString()
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: index % 2 == 0
                                      ? [
                                          const Color.fromARGB(
                                              255, 255, 250, 245),
                                          const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ]
                                      : [
                                          const Color.fromARGB(
                                              255, 245, 247, 255),
                                          const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            post.subject!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: index % 2 == 0
                                                  ? const Color.fromARGB(
                                                      255, 255, 127, 7)
                                                  : const Color.fromARGB(
                                                      255, 61, 82, 175),
                                              letterSpacing: 0.3,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? const Color.fromARGB(
                                                        255, 255, 127, 7)
                                                    .withOpacity(0.1)
                                                : const Color.fromARGB(
                                                        255, 61, 82, 175)
                                                    .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            DateFormat('MMM dd')
                                                .format(post.date_time!),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: index % 2 == 0
                                                  ? const Color.fromARGB(
                                                      255, 255, 127, 7)
                                                  : const Color.fromARGB(
                                                      255, 61, 82, 175),
                                            ),
                                          ),
                                        ),
                                        FutureBuilder<bool>(
                                          future: _authService.isAdmin(uid!),
                                          builder: (context, adminSnapshot) {
                                            final showDelete = post.userId ==
                                                    uid ||
                                                post.userId == username ||
                                                (adminSnapshot.data ?? false);

                                            return PopupMenuButton<String>(
                                              padding:
                                                  EdgeInsets.only(bottom: 23),
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
                                              itemBuilder:
                                                  (BuildContext context) {
                                                List<PopupMenuEntry<String>>
                                                    items = [
                                                  PopupMenuItem<String>(
                                                    value: 'reply',
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.reply,
                                                            color: Colors.blue,
                                                            size: 20),
                                                        SizedBox(width: 12),
                                                        Text('Reply'),
                                                      ],
                                                    ),
                                                  ),
                                                ];
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
                                                                color:
                                                                    Colors.red),
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
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        title: Text(
                                                            'Confirm Deletion'),
                                                        content: Text(
                                                            'Are you sure you want to delete this post?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    false),
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
                                                                    context,
                                                                    true),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      206,
                                                                      86,
                                                                      38),
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
                                                                  color: Colors
                                                                      .white),
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
                                                      .read(
                                                          forumNotifierProvider
                                                              .notifier)
                                                      .removePost(
                                                          post.discussionId!);
                                                  _refreshData();

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(_decorations
                                                          .bottomPopup(
                                                              "Forum Deleted",
                                                              Colors.green,
                                                              Colors.white));
                                                } else if (value == 'reply') {
                                                  showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Scaffold(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            body: Dialog(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    2.5,
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          20.0),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Reply",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: const Color.fromARGB(
                                                                                255,
                                                                                230,
                                                                                130,
                                                                                90),
                                                                            letterSpacing:
                                                                                0.5,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                16),
                                                                        TextField(
                                                                          controller:
                                                                              _replyController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                'Write your response here...',
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              borderSide: BorderSide(
                                                                                color: const Color.fromARGB(255, 230, 130, 90).withOpacity(0.3),
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              borderSide: BorderSide(
                                                                                color: const Color.fromARGB(255, 230, 130, 90),
                                                                                width: 2,
                                                                              ),
                                                                            ),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              color: const Color.fromARGB(255, 230, 130, 90).withOpacity(0.5),
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                            contentPadding:
                                                                                EdgeInsets.all(16),
                                                                          ),
                                                                          maxLines:
                                                                              8,
                                                                          scrollPhysics:
                                                                              ScrollPhysics(),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                24),
                                                                        Center(
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () async {
                                                                              if (_replyController.text == "") {
                                                                                print("here");
                                                                                ScaffoldMessenger.of(dialogContext).showSnackBar(
                                                                                  _decorations.bottomPopup(
                                                                                    "Please type a message and try again.",
                                                                                    const Color.fromARGB(255, 250, 123, 123),
                                                                                    Colors.white,
                                                                                  ),
                                                                                );
                                                                                return;
                                                                              }

                                                                              final confirmed = await showDialog<bool>(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(16),
                                                                                    ),
                                                                                    title: Text('Confirm reply'),
                                                                                    content: Text('Are you sure you want to post this reply?'),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(context, false),
                                                                                        child: Text(
                                                                                          'Cancel',
                                                                                          style: TextStyle(
                                                                                            color: Colors.grey[600],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      ElevatedButton(
                                                                                        onPressed: () => Navigator.pop(context, true),
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          backgroundColor: const Color.fromARGB(255, 206, 86, 38),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(8),
                                                                                          ),
                                                                                          elevation: 0,
                                                                                        ),
                                                                                        child: Text(
                                                                                          'Post',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              );

                                                                              if (confirmed != true) {
                                                                                return;
                                                                              }

                                                                              try {
                                                                                final reply = Forumreply(
                                                                                  userId: uid,
                                                                                  discussionId: post.discussionId,
                                                                                  reply: _replyController.text,
                                                                                  date_time: DateTime.now(),
                                                                                );
                                                                                ref.read(replyNotifierProvider.notifier).addReply(reply);

                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  _decorations.bottomPopup(
                                                                                    "Comment posted ✅",
                                                                                    Color.fromARGB(255, 76, 175, 80),
                                                                                    Colors.white,
                                                                                  ),
                                                                                );

                                                                                Navigator.of(dialogContext).pop();

                                                                                // Refresh after adding reply
                                                                                _refreshData();
                                                                              } catch (e) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  _decorations.bottomPopup(
                                                                                    'Error posting reply',
                                                                                    Colors.red,
                                                                                    Colors.white,
                                                                                  ),
                                                                                );
                                                                              }
                                                                            },
                                                                            style:
                                                                                _decorations.submitButtonStyle(),
                                                                            child:
                                                                                _decorations.buttonText("P O S T"),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ));
                                                      });

                                                  print('Reply button pressed');
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person_outlined,
                                          size: 18,
                                          color: Colors.grey[600],
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            post.userId!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13,
                                              color: Colors.grey[700],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Container(
                                      padding: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.grey[300]!,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        post.description!,
                                        style: TextStyle(
                                          fontSize: 15,
                                          height: 1.4,
                                          color:
                                              Color.fromARGB(255, 51, 50, 50),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
