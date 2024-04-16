import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/utilities/post_voting.dart';

void main() {
  group('Post Voting', () {
    test('should increment upvotes and toggle isUpvoted when post is upvoted',
        () {
      // Arrange
      Post post = Post(
          comments: 0,
          username: '',
          content: '',
          contentTitle: '',
          upvotes: 7,
          image: [],
          link: '',
          type: 'poll',
          video: '');
      post.isUpvoted = false;
      post.isDownvoted = false;
      post.upvotes = 0;

      // Act
      upVoteHandler(post);

      // Assert
      expect(post.upvotes, 1);
      expect(post.isUpvoted, true);
      expect(post.isDownvoted, false);
    });

    test(
        'should decrement upvotes and toggle isUpvoted when post is already upvoted',
        () {
      // Arrange
      Post post = Post(
          comments: 0,
          username: '',
          content: '',
          contentTitle: '',
          upvotes: 7,
          image: [],
          link: '',
          type: 'poll',
          video: '');
      post.isUpvoted = true;
      post.isDownvoted = false;
      post.upvotes = 1;

      // Act
      upVoteHandler(post);

      // Assert
      expect(post.upvotes, 0);
      expect(post.isUpvoted, false);
      expect(post.isDownvoted, false);
    });

    test(
        'should increment upvotes by 2 and toggle isUpvoted when post is downvoted',
        () {
      // Arrange
      Post post = Post(
          comments: 0,
          username: '',
          content: '',
          contentTitle: '',
          upvotes: 7,
          image: [],
          link: '',
          type: 'poll',
          video: '');
      post.isUpvoted = false;
      post.isDownvoted = true;
      post.upvotes = 0;

      // Act
      upVoteHandler(post);

      // Assert
      expect(post.upvotes, 2);
      expect(post.isUpvoted, true);
      expect(post.isDownvoted, false);
    });

    test(
        'should decrement upvotes and toggle isDownvoted when post is downvoted',
        () {
      // Arrange
      Post post = Post(
          comments: 0,
          username: '',
          content: '',
          contentTitle: '',
          upvotes: 7,
          image: [],
          link: '',
          type: 'poll',
          video: '');
      post.isUpvoted = false;
      post.isDownvoted = false;
      post.upvotes = 0;

      // Act
      downVoteHandler(post);

      // Assert
      expect(post.upvotes, -1); // Changed from 0 to -1
      expect(post.isUpvoted, false);
      expect(post.isDownvoted, true);
    });

    test(
        'should increment upvotes and toggle isDownvoted when post is already downvoted',
        () {
      // Arrange
      Post post = Post(
          comments: 0,
          username: '',
          content: '',
          contentTitle: '',
          upvotes: 7,
          image: [],
          link: '',
          type: 'poll',
          video: '');
      post.isUpvoted = false;
      post.isDownvoted = true;
      post.upvotes = -1;

      // Act
      downVoteHandler(post);

      // Assert
      expect(post.upvotes, 0);
      expect(post.isUpvoted, false);
      expect(post.isDownvoted, false);
    });

    test(
        'should decrement upvotes by 2 and toggle isDownvoted when post is upvoted',
        () {
      // Arrange
      Post post = Post(
          comments: 0,
          username: '',
          content: '',
          contentTitle: '',
          upvotes: 7,
          image: [],
          link: '',
          type: 'poll',
          video: '');
      post.isUpvoted = true;
      post.isDownvoted = false;
      post.upvotes = 1;

      // Act
      downVoteHandler(post);

      // Assert
      expect(post.upvotes, -1);
      expect(post.isUpvoted, false);
      expect(post.isDownvoted, true);
    });
  });
}