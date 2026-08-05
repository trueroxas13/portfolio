import 'package:acadeguide/models/forum_reply.dart';
import 'package:acadeguide/models/university.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:acadeguide/models/discussion_forum.dart';

void main() {
  test("Testing adding a discussion forum", () async {
    final testForum = Discussionforum(
      userId: 'user123',
      subject: 'Test Subject',
      description: 'Test Description',
      date_time: DateTime.now(),
    );

    final json = testForum.toJson();
    expect(json['userId'], 'user123');
    expect(json['subject'], 'Test Subject');
    expect(json['description'], 'Test Description');
    expect(json['date_time'], isNotNull);
    expect(testForum.userId, isNotEmpty);
    expect(testForum.subject, isNotEmpty);
  });

  test("Testing forum has valid data before adding", () {
    final testForum = Discussionforum(
      userId: 'user123',
      subject: 'Help',
      description: 'Need help with Flutter',
      date_time: DateTime(2025, 11, 12),
    );

    expect(testForum.userId, 'user123');
    expect(testForum.subject, 'Flutter Help');
    expect(testForum.description, 'Need help with Flutter');
    expect(testForum.date_time, isA<DateTime>());
  });

  test("Testing forum can be created from JSON", () {
    final json = {
      'id': 1,
      'userId': 'user123',
      'subject': 'Test Subject',
      'description': 'Test Description',
      'date_time': '2025-11-12T10:30:00.000Z',
    };
    final forum = Discussionforum.fromJson(json);

    expect(forum.discussionId, 1);
    expect(forum.userId, 'user123');
    expect(forum.subject, 'Test Subject');
    expect(forum.description, 'Test Description');
    expect(forum.date_time, isNotNull);
  });

  test("Testing forum JSON conversion is reversible", () {
  
    final originalForum = Discussionforum(
      userId: 'user123',
      subject: 'Test Subject',
      description: 'Test Description',
      date_time: DateTime(2025, 11, 12),
    );

    final json = originalForum.toJson();
    json['id'] = 1; 
    final recreatedForum = Discussionforum.fromJson(json);

    expect(recreatedForum.userId, originalForum.userId);
    expect(recreatedForum.subject, originalForum.subject);
    expect(recreatedForum.description, originalForum.description);
  });

  //Testin Replys
  test('Testing adding a reply to forum', () {
    final reply = Forumreply(
      id: 1,
      discussionId: 10,
      userId: 'user456',
      reply: 'This is a helpful answer!',
      date_time: DateTime(2025, 11, 12, 12, 30),
    );

    final forum = Discussionforum(
      discussionId: 10,
      userId: 'user123',
      subject: 'Flutter Help',
      description: 'Need help with Flutter layout',
      date_time: DateTime(2025, 11, 12),
    );

    final isReplyLinked = reply.discussionId == forum.discussionId;

    expect(isReplyLinked, true);
    expect(reply.reply, 'This is a helpful answer!');
    expect(reply.userId, 'user456');
    expect(reply.date_time, isA<DateTime>());
  });

  test('Testing reply Reading', () {
    final reply = Forumreply(
      id: 2,
      discussionId: 10,
      userId: 'user789',
      reply: 'Try using a Column instead of a Row.',
      date_time: DateTime(2025, 11, 12, 13, 0),
    );

    final json = reply.toJson();
    final recreatedReply = Forumreply.fromJson(json);

    expect(recreatedReply.id, reply.id);
    expect(recreatedReply.discussionId, reply.discussionId);
    expect(recreatedReply.userId, reply.userId);
    expect(recreatedReply.reply, reply.reply);
    expect(recreatedReply.date_time, isA<DateTime>());
  });

  test('Testing University Reading', () {
    final university = University(
      uniID: 'QTR123',
      uniName: 'Qatar University',
      uniCity: 'Doha',
      uniCountry: 'Qatar',
      uniLogo: 'https://example.com/logo.png',
      uniWebsite: 'https://www.qu.edu.qa',
      uniDescription: 'Leading national university in Qatar.',
      uniType: 'Public',
      uniMajors: ['Computer Science', 'Business', 'Engineering'],
      tuitionAvg: 25000.0,
    );
    final json = {
      'uniID': university.uniID,
      'uniName': university.uniName,
      'uniCity': university.uniCity,
      'uniCountry': university.uniCountry,
      'uniLogo': university.uniLogo,
      'uniWebsite': university.uniWebsite,
      'uniDescription': university.uniDescription,
      'uniType': university.uniType,
      'uniMajors': university.uniMajors,
      'tuitionAvg': university.tuitionAvg,
    };

    final recreatedUniversity = University.fromJson(json);
    expect(recreatedUniversity.uniID, university.uniID);
    expect(recreatedUniversity.uniName, university.uniName);
    expect(recreatedUniversity.uniCity, university.uniCity);
    expect(recreatedUniversity.uniCountry, university.uniCountry);
    expect(recreatedUniversity.uniLogo, university.uniLogo);
    expect(recreatedUniversity.uniWebsite, university.uniWebsite);
    expect(recreatedUniversity.uniDescription, university.uniDescription);
    expect(recreatedUniversity.uniType, university.uniType);
    expect(recreatedUniversity.uniMajors, isA<List<String>>());
    expect(recreatedUniversity.uniMajors, university.uniMajors);
    expect(recreatedUniversity.tuitionAvg, university.tuitionAvg);
  });
}
