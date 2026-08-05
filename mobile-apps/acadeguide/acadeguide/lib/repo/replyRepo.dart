import 'package:acadeguide/models/forum_reply.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Replyrepo {
  final db = Supabase.instance.client.from('forum_reply');

  //Add reply forum
  Future addReply(Forumreply reply) async {
    await db.insert(reply.toJson());
  }

  //Get all replies
  Stream<List<Forumreply>> getReplyForums() {
    return Supabase.instance.client
        .from('forum_reply')
        .stream(primaryKey: ['id']).map(
      (data) => data.map<Forumreply>((e) => Forumreply.fromJson(e)).toList(),
    );
  }

//getting replies by user id along the forum
  Stream<List<Forumreply>> getRepliesByUser(String userId) {
    return db.stream(primaryKey: ['id']).eq('user_id', userId).map(
        (data) => data.map<Forumreply>((e) => Forumreply.fromJson(e)).toList());
  }

  Future<List<Forumreply>> getRepliesByPostId(int postId) async {
    final data = await db.select().eq('discussion_id', postId);
    return data.map<Forumreply>((e) => Forumreply.fromJson(e)).toList();
  }

  //Delete reply
  Future deleteReply(int id) async {
    await db.delete().eq("id", id);
  }
}
