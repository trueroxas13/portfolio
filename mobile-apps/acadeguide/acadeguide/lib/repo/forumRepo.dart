import 'package:acadeguide/models/discussion_forum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Forumrepo {
  final db = Supabase.instance.client.from('discussion_forum');

  //Add discussion forum
  Future addDiscussionForum(Discussionforum forum) async {
    await db.insert(forum.toJson());
  }

  //Get all discussion forums
  Stream<List<Discussionforum>> getDiscussionForums() {
    return db.stream(primaryKey: ['id']).map(
      (data) => data
          .map<Discussionforum>((e) => Discussionforum.fromJson(e))
          .toList(),
    );
  }

  // Future<List<Discussionforum>> getForumsByUser(String userId) {
  //   return db.stream(primaryKey: ['id']).eq('user_id', userId).map((data) =>
  //       data.map<Discussionforum>((e) => Discussionforum.fromJson(e)).toList());
  // }

// In Forumrepo class
  Future<Discussionforum> getDiscussionForumById(int id) async {
    final data = await db.select().eq('id', id).single();

    return Discussionforum.fromJson(data);
  }

  //Delete discussion forum

  Future deleteDiscussionForum(int id) async {
    await db.delete().eq("id", id.toString());
  }

  Stream<List<Discussionforum>> searchDiscussionForums(String query) {
    return getDiscussionForums().map((forums) {
      if (query.isEmpty) {
        return forums;
      }
      // Filter in Dart - case insensitive partial match
      final lowerQuery = query.toLowerCase();
      return forums.where((forum) {
        final subject = forum.subject?.toLowerCase() ?? '';
        return subject.contains(lowerQuery);
      }).toList();
    });
  }
}
