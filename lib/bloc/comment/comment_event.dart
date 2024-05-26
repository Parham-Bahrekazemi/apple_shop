abstract class CommentEvent {}

class CommentInitEvent extends CommentEvent {
  String productId;
  CommentInitEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  String commentText;

  String productId;

  CommentPostEvent(this.commentText, this.productId);
}
