import 'package:acadeguide/models/forum_reply.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase/supabase.dart' as supabase_core;
import 'package:acadeguide/models/discussion_forum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DirectForumTester {
  late supabase_core.SupabaseClient client;
  final List<int> createdForumIds = [];
  final List<int> creaetedReplyIds = [];

  Future<void> initialize() async {
    client = supabase_core.SupabaseClient(
        "https://hejignvhxjwaczixzesg.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhlamlnbnZoeGp3YWN6aXh6ZXNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUxMzUwNjMsImV4cCI6MjA2MDcxMTA2M30.GaqqyaeJPxHOJJlityj0e-CaSNhPndMjRr_gkYpomtc");
  }

  Future<void> addForum(Discussionforum forum) async {
    final response = await client
        .from('discussion_forum')
        .insert(forum.toJson())
        .select()
        .single();

    createdForumIds.add(response['id'] as int);
  }

  Future<List<Discussionforum>> getAllForums() async {
    final response = await client
        .from('discussion_forum')
        .select()
        .order('id', ascending: true);

    return (response as List).map((e) => Discussionforum.fromJson(e)).toList();
  }

  Future<Discussionforum> getForumById(int id) async {
    final response =
        await client.from('discussion_forum').select().eq('id', id).single();

    return Discussionforum.fromJson(response);
  }

  Future<List<Discussionforum>> searchForums(String query) async {
    final allForums = await getAllForums();

    if (query.isEmpty) return allForums;

    final lowerQuery = query.toLowerCase();
    return allForums.where((forum) {
      final subject = forum.subject?.toLowerCase() ?? '';
      return subject.contains(lowerQuery);
    }).toList();
  }

  Future<void> deleteForum(int id) async {
    await client.from('discussion_forum').delete().eq('id', id);
  }

  Future<List<Forumreply>> getReplyForums() async {
    final response =
        await client.from('forum_reply').select().order("id", ascending: true);
    return (response as List).map((e) => Forumreply.fromJson(e)).toList();
  }

  Future<void> addReply(Forumreply reply) async {
    final response = await client
        .from("forum_reply")
        .insert(reply.toJson())
        .select()
        .single();

    creaetedReplyIds.add(response['id'] as int);
  }

  Future<void> deleteReply(int id) async {
    await client.from("forum_reply").delete().eq("id", id);
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth
        .signInWithPassword(password: password, email: email);
  }

  Future<AuthResponse> signup(
    String email,
    String password,
    String username,
    String firstname,
    String lastname,
    String interests,
  ) async {
    return client.auth.signUp(
      password: password,
      email: email,
      data: {
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'interests': interests,
      },
    );
  }

  Future<void> updateUserData(
    String username,
    String firstname,
    String lastname,
    String interests,
  ) async {
    final session = client.auth.currentSession;
    final user = session?.user;
    if (user != null) {
      await client.auth.updateUser(
        UserAttributes(
          data: {
            'username': username,
            'firstname': firstname,
            'lastname': lastname,
            'interests': interests,
          },
        ),
      );
    }
  }

  Future<void> cleanupForums() async {
    for (final id in createdForumIds) {
      try {
        await deleteForum(id);
      } catch (e) {
        print('Failed to delete forum $id: $e');
      }
    }
    createdForumIds.clear();
  }

  Future<void> cleanupReplies() async {
    for (final id in creaetedReplyIds) {
      try {
        await deleteForum(id);
      } catch (e) {
        print('Failed to delete forum $id: $e');
      }
    }
    creaetedReplyIds.clear();
  }

  void dispose() {
    client.dispose();
  }
}

void main() {
  late DirectForumTester tester;

  setUpAll(() async {
    tester = DirectForumTester();
    await tester.initialize();
  });

  tearDown(() async {
    await tester.cleanupForums();
    await tester.cleanupReplies();
  });

  tearDownAll(() {
    tester.dispose();
  });

  group('Forum CRUD Operations - Direct Client', () {
    test('Add forum and verify it exists', () async {
      final forum = Discussionforum(
        userId: 'test_user_${DateTime.now().millisecondsSinceEpoch}',
        subject: 'Integration Test Forum',
        description: 'Testing with direct client',
        date_time: DateTime.now(),
      );

      await tester.addForum(forum);

      final forums = await tester.getAllForums();
      expect(forums, isNotEmpty);
      expect(
        forums.any((f) => f.subject == 'Integration Test Forum'),
        isTrue,
      );
    });

    test('Get all forums returns list', () async {
      await tester.addForum(Discussionforum(
        userId: 'test_user_1',
        subject: 'Forum 1',
        description: 'Description 1',
        date_time: DateTime.now(),
      ));

      await tester.addForum(Discussionforum(
        userId: 'test_user_2',
        subject: 'Forum 2',
        description: 'Description 2',
        date_time: DateTime.now(),
      ));

      final forums = await tester.getAllForums();

      expect(forums.length, greaterThanOrEqualTo(2));
    });

    test('Get forum by ID returns correct forum', () async {
      final forum = Discussionforum(
        userId: 'test_user_id',
        subject: 'Specific Forum',
        description: 'For ID test',
        date_time: DateTime.now(),
      );
      await tester.addForum(forum);

      final addedId = tester.createdForumIds.last;
      final retrievedForum = await tester.getForumById(addedId);

      expect(retrievedForum.discussionId, equals(addedId));
      expect(retrievedForum.subject, equals('Specific Forum'));
    });

    test('Search forums filters by subject', () async {
      await tester.addForum(Discussionforum(
        userId: 'search_user',
        subject: 'Flutter Development',
        description: 'About Flutter',
        date_time: DateTime.now(),
      ));

      await tester.addForum(Discussionforum(
        userId: 'search_user',
        subject: 'Dart Programming',
        description: 'About Dart',
        date_time: DateTime.now(),
      ));

      final flutterResults = await tester.searchForums('Flutter');
      final dartResults = await tester.searchForums('Dart');
      final emptyResults = await tester.searchForums('');

      expect(
        flutterResults.any((f) => f.subject?.contains('Flutter') ?? false),
        isTrue,
      );
      expect(
        dartResults.any((f) => f.subject?.contains('Dart') ?? false),
        isTrue,
      );
      expect(emptyResults.length, greaterThanOrEqualTo(2));
    });

    test('Delete forum removes it from database', () async {
      final forum = Discussionforum(
        userId: 'delete_user',
        subject: 'Forum to Delete',
        description: 'Will be removed',
        date_time: DateTime.now(),
      );
      await tester.addForum(forum);
      final forumId = tester.createdForumIds.last;

      await tester.deleteForum(forumId);

      final forums = await tester.getAllForums();
      expect(forums.any((f) => f.discussionId == forumId), isFalse);

      tester.createdForumIds.remove(forumId);
    });

    test('Add reply and verify it exists', () async {
      // Arrange
      final reply = Forumreply(
        discussionId: 6,
        userId: 'reply_user_${DateTime.now().millisecondsSinceEpoch}',
        reply: 'This is a test reply',
        date_time: DateTime.now(),
      );

      await tester.addReply(reply);
      final replies = await tester.getReplyForums();
      expect(replies, isNotEmpty);
      expect(
        replies.any((r) => r.reply == 'This is a test reply'),
        isTrue,
      );
    });

    test('Get all replies returns list', () async {
      await tester.addReply(Forumreply(
        discussionId: 6,
        userId: 'reply_user_1',
        reply: 'First reply',
        date_time: DateTime.now(),
      ));

      await tester.addReply(Forumreply(
        discussionId: 6,
        userId: 'reply_user_2',
        reply: 'Second reply',
        date_time: DateTime.now(),
      ));

      final replies = await tester.getReplyForums();

      expect(replies.length, greaterThanOrEqualTo(2));
    });

    test('Delete reply removes it from database', () async {
      final reply = Forumreply(
        discussionId: 6,
        userId: 'delete_reply_user',
        reply: 'Reply to delete',
        date_time: DateTime.now(),
      );
      await tester.addReply(reply);
      final replyId = tester.creaetedReplyIds.last;

      await tester.deleteReply(replyId);
      final replies = await tester.getReplyForums();
      expect(replies.any((r) => r.id == replyId), isFalse);
      print('Reply deleted successfully');

      tester.creaetedReplyIds.remove(replyId);
    });

    test("Testing signing in with email and password", () async {
      final email = "omarqu2003@gmail.com";
      final password = "password123";
      final session = await tester.signIn(email, password);
      expect(session, isNotNull,
          reason: "Session should not be null after login");
      expect(session.user, isNotNull, reason: "User should be returned");
      expect(session.user!.email, equals(email));

      final currentUser = tester.client.auth.currentUser;
      expect(currentUser, isNotNull);
      expect(currentUser!.email, equals(email));
    });

    test("Testing signup", () async {
      final email = "okamqutb119@gmail.com";
      final password = "password123";
      final username = "joj1123";
      final firstname = "yousef";
      final lastname = "usertest";
      final interests = "";

      final session = await tester.signup(
          email, password, username, firstname, lastname, interests);

      //Cannot be tested fully as the user has to verfiy his email

      expect(session, isNotNull,
          reason: "Signup should return a valid session");
      expect(session.user, isNotNull, reason: "User should be created");
      expect(session.user!.email, equals(email));
    });

    test("Update user data", () async {
      final email = "omarqu2003@gmail.com";
      final password = "password123";
      final username = "joj1123";
      final firstname = "yousef";
      final lastname = "usertest";
      final interests = "";

      await tester.signIn(email, password);
      await tester.updateUserData(username, firstname, lastname, interests);

      final updatedUser = tester.client.auth.currentUser;
      expect(updatedUser, isNotNull,
          reason: "Updated user should still be logged in");
      final metadata = updatedUser!.userMetadata ?? {};
      expect(metadata['username'], equals(username));
      expect(metadata['firstname'], equals(firstname));
      expect(metadata['lastname'], equals(lastname));
      expect(metadata['interests'], equals(interests));
    });
  });
}
