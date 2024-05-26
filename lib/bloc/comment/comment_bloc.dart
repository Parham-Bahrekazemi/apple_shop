import 'package:apple_shop/bloc/comment/comment_event.dart';
import 'package:apple_shop/bloc/comment/comment_state.dart';
import 'package:apple_shop/data/model/comment_model.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:apple_shop/di.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _repository = locator.get();
  CommentBloc() : super(CommentInitState()) {
    on<CommentInitEvent>((event, emit) async {
      emit(CommentLoadingState());

      Either<String, List<CommentModel>> listComments =
          await _repository.getComments(event.productId);

      emit(CommentSuccessState(listComments));
    });

    on<CommentPostEvent>((event, emit) async {
      emit(CommentPostLoadingState(true));
      emit(CommentLoadingState());
      Either<String, String> response =
          await _repository.postComments(event.commentText, event.productId);
      emit(CommentPostLoadingState(false));

      Either<String, List<CommentModel>> listComments =
          await _repository.getComments(event.productId);

      emit(CommentSuccessState(listComments));
      // emit(CommentPostSuccessState(response));
    });
  }
}
