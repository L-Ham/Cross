import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

void upVoteHandler(Post post) {
  ApiService apiService = ApiService(TokenDecoder.token);
  if (post.isUpvoted) {
    post.upvotes--;
    post.isUpvoted = !post.isUpvoted;
    post.isDownvoted = false;
    apiService.cancelUpvote(post.postId);
  } else if (post.isDownvoted) {
    post.upvotes += 2;
    post.isUpvoted = true;
    post.isDownvoted = false;
    apiService.upvotePost(post.postId);
  } else {
    post.upvotes++;
    post.isUpvoted = !post.isUpvoted;
    apiService.upvotePost(post.postId);
  }
}

void downVoteHandler(Post post) {
  ApiService apiService = ApiService(TokenDecoder.token);
  if (post.isDownvoted) {
    post.upvotes++;
    post.isDownvoted = !post.isDownvoted;
    apiService.cancelDownvote(post.postId);
  } else if (post.isUpvoted) {
    post.upvotes -= 2;
    post.isDownvoted = true;
    post.isUpvoted = false;
    apiService.downvotePost(post.postId);
  } else {
    post.upvotes--;
    post.isDownvoted = !post.isDownvoted;
    apiService.downvotePost(post.postId);
  }
}
