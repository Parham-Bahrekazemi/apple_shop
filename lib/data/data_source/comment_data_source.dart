import 'package:apple_shop/data/model/comment_model.dart';
import 'package:apple_shop/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:apple_shop/utils/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class ICommentDataSource {
  Future<List<CommentModel>> getComments(String productId);

  Future<void> postComments(String commentText, String productId);
}

class CommentRemoteDataSource extends ICommentDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<CommentModel>> getComments(String productId) async {
    print('product_id="$productId"');
    try {
      Response responseForPage = await _dio.get(
        'collections/comment/records',
        queryParameters: {
          'filter': 'product_id="$productId"',
          'expand': 'user_id',
        },
      );

      int page = responseForPage.data['totalPages'];

      Map<String, dynamic> params = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id',
        'page': page,
      };
      Response response = await _dio.get(
        'collections/comment/records',
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        List<CommentModel> listComments =
            response.data['items'].map<CommentModel>(
          (jsonObject) {
            Map<String, dynamic>? expand = jsonObject['expand'];
            if (expand != null) {
              return CommentModel.fromJson(jsonObject);
            } else {
              return CommentModel.fromJson({
                "collectionId": "dw2ip5h24i9573z",
                "collectionName": "comment",
                "created": "2023-10-27 14:03:43.321Z",
                "expand": {
                  "user_id": {
                    "avatar": "",
                    "collectionId": "_pb_users_auth_",
                    "collectionName": "users",
                    "created": "2023-07-30 08:39:40.780Z",
                    "emailVisibility": false,
                    "id": "lkg8xc50i07oedn",
                    "name": "",
                    "updated": "2023-07-30 08:39:40.780Z",
                    "username": "AydinTaeb1",
                    "verified": false
                  }
                },
                "id": "n7hgekbbqmf6fpw",
                "product_id": "ud5m8v9ijxd81rn",
                "text": "naro",
                "updated": "2023-10-27 14:03:43.321Z",
                "user_id": "lkg8xc50i07oedn"
              });
            }
          },
        ).toList();

        return listComments.reversed.toList();
      }
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, '$e');
    }

    return [];
  }

  @override
  Future<void> postComments(String commentText, String productId) async {
    try {
      await _dio.post(
        'http://startflutter.ir/api/collections/comment/records',
        data: {
          'text': commentText,
          'user_id': AuthManager.readUserId(),
          'product_id': productId,
        },
      );
    } on DioException catch (e) {
      throw CustomApiException(e.response?.statusCode, e.message);
    } catch (e) {
      throw CustomApiException(0, 'unknown error');
    }
  }
}
