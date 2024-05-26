import 'package:apple_shop/data/data_source/comment_data_source.dart';
import 'package:apple_shop/data/model/comment_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<CommentModel>>> getComments(String productId);
  Future<Either<String, String>> postComments(
      String commentText, String productId);
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<CommentModel>>> getComments(
      String productId) async {
    try {
      List<CommentModel> listComments =
          await _dataSource.getComments(productId);
      return Right(listComments);
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> postComments(
      String commentText, String productId) async {
    try {
      await _dataSource.postComments(commentText, productId);
      return const Right('کامنت با موفقیت ثبت شد');
    } on CustomApiException catch (e) {
      return Left(e.message ?? 'لیست بنر گرفته نشد');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
