import 'package:apple_shop/data/model/comment_model.dart';
import 'package:dartz/dartz.dart';

abstract class CommentState {}

class CommentInitState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentSuccessState extends CommentState {
  Either<String, List<CommentModel>> listComments;

  CommentSuccessState(this.listComments);
}

class CommentPostLoadingState extends CommentState {
  bool loading;
  CommentPostLoadingState(this.loading);
}

class CommentPostSuccessState extends CommentState {
  Either<String, String> commentPost;
  CommentPostSuccessState(this.commentPost);
}
