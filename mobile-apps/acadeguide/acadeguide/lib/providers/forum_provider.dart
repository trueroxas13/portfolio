import 'package:acadeguide/models/discussion_forum.dart';
import 'package:acadeguide/repo/forumRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumNotifer extends Notifier<String> {
  final Forumrepo _forumRepo = Forumrepo();

  @override
  String build() {
    return ''; // Store current search query
  }

  Stream<List<Discussionforum>> getPosts() {
    // Return filtered stream based on search query
    if (state.isEmpty) {
      return _forumRepo.getDiscussionForums();
    } else {
      return _forumRepo.searchDiscussionForums(state);
    }
  }

  void addPost(Discussionforum forum) async {
    Stopwatch stopwatch = Stopwatch()..start();
    await _forumRepo.addDiscussionForum(forum).then((value) {
      stopwatch.stop();
      print('Time taken to add post: ${stopwatch.elapsedMilliseconds} ms');
    },);
  }

  void removePost(int postId) async {
    Stopwatch stopwatch = Stopwatch()..start();
    await _forumRepo.deleteDiscussionForum(postId).then((value) {
      stopwatch.stop();
      print('Time taken to remove post: ${stopwatch.elapsedMilliseconds} ms');
    },);
  }

  void searchForum(String query) {
    state = query; // Update search query
  }

  // Future<List<Discussionforum>> getPostsByUser(String userId) {
  //   return _forumRepo.getForumsByUser(userId);
  // }

  Future<Discussionforum> getPostById(int id) {
    return _forumRepo.getDiscussionForumById(id);
  }
}

final forumNotifierProvider = NotifierProvider<ForumNotifer, String>(() {
  return ForumNotifer();
});
