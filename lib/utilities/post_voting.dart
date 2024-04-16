import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
  void upVoteHandler(Post post) {
    if (post.isUpvoted) {
      post.upvotes--;
      post.isUpvoted = !post.isUpvoted;
      post.isDownvoted = false;
    } else if (post.isDownvoted) {
      post.upvotes += 2;
      post.isUpvoted = true;
      post.isDownvoted = false;
    } else {
      post.upvotes++;
      post.isUpvoted = !post.isUpvoted;
    }
  }

  void downVoteHandler(Post post) {
    if (post.isDownvoted) {
      post.upvotes++;
      post.isDownvoted = !post.isDownvoted;
    } else if (post.isUpvoted) {
      post.upvotes -= 2;
      post.isDownvoted = true;
      post.isUpvoted = false;
    } else {
      post.upvotes--;
      post.isDownvoted = !post.isDownvoted;
    }
  }