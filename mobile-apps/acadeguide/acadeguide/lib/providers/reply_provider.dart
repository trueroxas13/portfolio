import 'package:acadeguide/models/forum_reply.dart';
import 'package:acadeguide/repo/replyRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReplyNotifer extends Notifier<List<String>> {
  final Replyrepo _replyrepo = Replyrepo();
  List<Forumreply> _allReplies = <Forumreply>[];

  @override
  List<String> build() {
    return [];
  }

  Stream<List<Forumreply>> getReplies() {
    return _replyrepo.getReplyForums();
  }

  void addReply(Forumreply reply) async {
    Stopwatch stopwatch = Stopwatch()..start();
    await _replyrepo.addReply(reply).then((value) {
      stopwatch.stop();
      print('Time taken to add reply: ${stopwatch.elapsedMilliseconds} ms');
    },);
  }

  void removeReply(int replyId) async {
    Stopwatch stopwatch = Stopwatch()..start();
    await _replyrepo.deleteReply(replyId).then((value) {
      stopwatch.stop();
      print('Time taken to remove reply: ${stopwatch.elapsedMilliseconds} ms');
    },);
  }

  Stream<List<Forumreply>> getRepliesByUser(String userId) {
    return _replyrepo.getRepliesByUser(userId);
  }

  Future<List<Forumreply>> getRepliesByPostId(int postId) async{
    Stopwatch stopwatch = Stopwatch()..start();
    return await _replyrepo.getRepliesByPostId(postId).then((value) {
      stopwatch.stop();
      print('Time taken to get replies by post ID: ${stopwatch.elapsedMilliseconds} ms');
      return value;
    },);
  }
}

final replyNotifierProvider = NotifierProvider<ReplyNotifer, List<String>>(() {
  return ReplyNotifer();
});
